import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/detail_collection/collection_related/view/collections_related.dart';
import 'package:hd_splash_flutter/views/detail_collection/detail_collection.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class DetailCollectionPage extends StatelessWidget {
  const DetailCollectionPage({Key? key, required this.collection})
      : super(key: key);
  final Collection collection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: false,
        title: Text(
          collection.title,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [ButtonOpenUrlHtml(uri: collection.links.html)],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomMasonryGirdPhotos(
                    loadMoreData: (isLoadMore) {
                      if (isLoadMore) {
                        context.read<DetailCollectionCubit>().nextPagePhotos();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => CollectionsRelatedView(
                    idCollection: collection.id,
                  ));
        },
        child: const Icon(Icons.expand_less),
      ),
    );
  }
}
