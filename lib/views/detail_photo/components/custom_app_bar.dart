import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/core/utils/share_fu.dart';
import 'package:hd_splash_flutter/logic/cubits/auth/auth_cubit.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

import '../detail_photo.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPhotoCubit, DetailPhotoState>(
      buildWhen: (previous, current) => previous.photo != current.photo,
      builder: (context, state) {
        final photo = state.photo;
        return AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(
                Icons.bookmark_add,
                color: state.photo.currentUserCollections.isNotEmpty
                    ? Colors.teal
                    : Colors.black,
              ),
              onPressed: () {
                final authenticated =
                    context.read<AuthCubit>().state is Authenticated;
                if (authenticated) {
                  final cubitPage = context.read<DetailPhotoCubit>();
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => BottomModalAddPhotoCollections(
                            currentUserCollections:
                                photo.currentUserCollections,
                            detailPhotoCubit: cubitPage,
                          ));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => const NotificationDialog());
                }
              },
            ),
            ButtonOpenUrlHtml(
              uri: photo.links.html,
            ),
            IconButton(
                onPressed: () {
                  share(photo.links.html);
                },
                icon: const Icon(Icons.share))
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class BottomModalAddPhotoCollections extends StatelessWidget {
  const BottomModalAddPhotoCollections(
      {Key? key,
      required this.currentUserCollections,
      required this.detailPhotoCubit})
      : super(key: key);
  final List<String> currentUserCollections;
  final DetailPhotoCubit detailPhotoCubit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                width: 50,
                height: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: Text(
                  "Add photo to a collection",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 170,
              child: BlocSelector<AuthCubit, AuthState, Authenticated>(
                selector: (state) {
                  return state as Authenticated;
                },
                builder: (context, state) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.collections.length,
                      itemBuilder: ((context, index) {
                        bool isPhotoInCollection = currentUserCollections
                            .contains(state.collections[index].id);
                        return Container(
                          margin: EdgeInsets.only(
                              left: index == 0 ? 16 : 0, right: 8),
                          child: StatefulBuilder(
                            builder: (context, setState) => ItemCollection(
                              isPhotoInCollection: isPhotoInCollection,
                              collection: state.collections[index],
                              onTap: () {
                                if (isPhotoInCollection) {
                                  detailPhotoCubit.removePhotoInCollection(
                                      state.collections[index].id);
                                  setState(
                                    () {
                                      isPhotoInCollection = false;
                                    },
                                  );
                                } else {
                                  detailPhotoCubit.addPhotoInCollection(
                                      state.collections[index].id);

                                  setState(
                                    () {
                                      isPhotoInCollection = true;
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCollection extends StatelessWidget {
  const ItemCollection(
      {Key? key,
      required this.collection,
      required this.isPhotoInCollection,
      required this.onTap})
      : super(key: key);
  final Collection collection;
  final bool isPhotoInCollection;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    String uri = "";
    if (collection.coverPhoto != null) {
      uri = collection.coverPhoto!.urls.regular;
    } else if (collection.previewPhotos.isNotEmpty) {
      uri = collection.previewPhotos[0].urls.regular;
    } else {
      uri = collection.user.profileImage.large;
    }
    return GestureDetector(
        onTap: onTap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: context.screenSize.width * 1 / 2,
              height: 170,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: collection.coverPhoto?.color.converterColor,
                    child: CustomCacheNetworkImage(
                      imageUrl: uri,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Text(
                              collection.title,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${collection.totalPhotos} ${context.lang("photos")}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          collection.user.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      color: isPhotoInCollection ? Colors.black45 : null,
                      child: isPhotoInCollection
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 30,
                            )
                          : null,
                    ))
              ]),
            )));
  }
}
