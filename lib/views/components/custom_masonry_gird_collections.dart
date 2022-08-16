import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/logic/cubits/app_setting/app_setting_cubit.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class CustomMasonryGirdCollections extends StatelessWidget {
  const CustomMasonryGirdCollections(
      {Key? key,
      required this.collections,
      required this.onRefresh,
      this.shrinkWrap,
      required this.loadMoreData,
      this.actionDeleteCollection})
      : super(key: key);
  final List<Collection> collections;
  final Function(bool) loadMoreData;
  final Future<void> Function() onRefresh;
  final bool? shrinkWrap;
  final Function(AppAction)? actionDeleteCollection;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          bool isBottom = metrics.pixels == 0;
          if (!isBottom) {
            loadMoreData(true);
          }
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          buildWhen: (previous, current) {
            if ((previous.crossAxisCountGird != current.crossAxisCountGird) ||
                (previous.loadQualityType != current.loadQualityType)) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return MasonryGridView.count(
                padding: const EdgeInsets.only(top: 10),
                itemCount: collections.length,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: state.crossAxisCountGird,
                shrinkWrap: shrinkWrap ?? false,
                itemBuilder: ((context, index) {
                  final collection = collections[index];
                  String uri = "";
                  if (collection.coverPhoto != null) {
                    uri = collection.coverPhoto!.urls
                        .photoUrl(state.loadQualityType);
                  } else if (collection.previewPhotos.isNotEmpty) {
                    uri = collection.previewPhotos[0].urls
                        .photoUrl(state.loadQualityType);
                  } else {
                    uri = collection.user.profileImage.large;
                  }
                  return GestureDetector(
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                            context, RouteName.detailCollection,
                            arguments: collection);
                        if (result == AppAction.deleteCollection) {
                          actionDeleteCollection!(AppAction.deleteCollection);
                        } else if (result == AppAction.updateCollection) {
                          actionDeleteCollection!(AppAction.updateCollection);
                        }
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Stack(children: [
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: collection
                                      .coverPhoto?.color.converterColor,
                                  child: CustomCacheNetworkImage(
                                    key: ValueKey(collection.id),
                                    placeholder: false,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            collection.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(color: Colors.white),
                                          ),
                                          if (collection.private)
                                            const Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Icon(
                                                Icons.lock,
                                                size: 10,
                                              ),
                                            )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${collection.totalPhotos} ${context.lang("photos")}'
                                            .toLowerCase(),
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
                              )
                            ]),
                          )));
                }));
          },
        ),
      ),
    );
  }
}
