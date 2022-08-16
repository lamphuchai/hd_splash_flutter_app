import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/detail_collection/detail_collection.dart';

class DetailCollectionPage extends StatelessWidget {
  const DetailCollectionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailCollectionCubit, DetailCollectionState>(
      listener: (context, state) {
        switch (state.actionCollection) {
          case ActionCollection.deleteCollection:
            Navigator.pop(context, AppAction.deleteCollection);
            break;
          case ActionCollection.actionError:
            ScaffoldMessenger.of(context)
                .showSnackBar(customSnackBar("Delete collection fail"));
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: BlocBuilder<DetailCollectionCubit, DetailCollectionState>(
                buildWhen: (previous, current) =>
                    previous.collection != current.collection,
                builder: (context, state) {
                  final collection = state.collection;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteName.user,
                                    arguments: collection.user),
                                child: CircleAvatar(
                                    maxRadius: 30,
                                    backgroundImage: CachedNetworkImageProvider(
                                        collection.user.profileImage.large)),
                              )),
                          Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Text(
                                      '${context.lang("curated-by")} ${collection.user.name}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      '${collection.totalPhotos} ${context.lang("photos")}')
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${context.lang("create")} : ${collection.publishedAt.formatTimeString}'),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                '${context.lang("update")} : ${collection.updatedAt.formatTimeString}'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              ),
            )
          ],
          body: BlocBuilder<DetailCollectionCubit, DetailCollectionState>(
            builder: (context, state) {
              switch (state.statusType) {
                case StatusType.loading:
                  return const AppLoadingWidget();
                case StatusType.error:
                  return const AppErrorWidget();
                case StatusType.loaded:
                  if (state.photos.isEmpty) {
                    return const EmptyDataWidget();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomMasonryGirdPhotos(
                      loadMoreData: (isLoadMore) {
                        if (isLoadMore) {
                          context
                              .read<DetailCollectionCubit>()
                              .nextPagePhotos();
                        }
                      },
                      onRefresh: () async =>
                          context.read<DetailCollectionCubit>().loadingPhotos(),
                      photos: state.photos,
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
        floatingActionButton:
            BlocBuilder<DetailCollectionCubit, DetailCollectionState>(
          buildWhen: (previous, current) =>
              previous.relatedCollections != current.relatedCollections,
          builder: (context, state) {
            final relatedCollection = state.relatedCollections;
            if (relatedCollection.isEmpty) {
              return const SizedBox();
            }
            return FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => CollectionsRelated(
                          relatedCollection: relatedCollection,
                        ));
              },
              child: const Icon(Icons.expand_less),
            );
          },
        ),
      ),
    );
  }
}
