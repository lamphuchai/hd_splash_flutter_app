import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/detail_topic/detail_topic.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class DetailTopicPage extends StatelessWidget {
  const DetailTopicPage({Key? key, required this.topic}) : super(key: key);
  final Topic topic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(topic.title),
        actions: [ButtonOpenUrlHtml(uri: topic.links.html)],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              children: const [
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
        body: BlocBuilder<DetailTopicCubit, DetailTopicState>(
          builder: (context, state) {
            switch (state.statusType) {
              case StatusType.loading:
                return const AppLoadingWidget();
              case StatusType.error:
                return const AppErrorWidget();
              case StatusType.loaded:
                print(state.photos.length);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomMasonryGirdPhotos(
                    loadMoreData: (isLoadMore) {
                      if (isLoadMore) {
                        context.read<DetailTopicCubit>().nextPagePhotos();
                      }
                    },
                    onRefresh: () async =>
                        context.read<DetailTopicCubit>().loadingPhotos(),
                    photos: state.photos,
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
      floatingActionButton: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(40)),
        child: BlocBuilder<DetailTopicCubit, DetailTopicState>(
          buildWhen: (previous, current) =>
              previous.photosOrderBy != current.photosOrderBy,
          builder: (context, state) {
            return ButtonSortOrderBy(
              selected: state.photosOrderBy,
              listValue: TopicPhotosOrderBy.values,
              onSelected: (orderBy) =>
                  context.read<DetailTopicCubit>().changeOrderBy(orderBy),
            );
          },
        ),
      ),
    );
  }
}
