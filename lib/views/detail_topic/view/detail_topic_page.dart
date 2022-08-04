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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case StatusType.loaded:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomMasonryGirdView(
                    onNotification: (scrollEnd) {
                      final metrics = scrollEnd.metrics;
                      if (metrics.atEdge) {
                        bool isBottom = metrics.pixels == 0;
                        if (!isBottom) {
                          context.read<DetailTopicCubit>().nextPagePhotos();
                        }
                      }
                      return true;
                    }, 
                    onRefresh: () async =>
                        context.read<DetailTopicCubit>().loadingPhotos(),
                    photos: state.photos,
                  ),
                );
              case StatusType.error:
                return const Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
