import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/topics/topics.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class CustomSliverListTopics extends StatelessWidget {
  const CustomSliverListTopics({
    Key? key,
    required this.topics,
  }) : super(key: key);

  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<TopicsCubit>().loadingTopics(),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final topic = topics[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, RouteName.detailTopic,
                      arguments: topic),
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
                            color: topic.coverPhoto?.color.converterColor,
                            child: CustomCacheNetworkImage(
                              imageUrl: topic.coverPhoto!.urls.regular,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    topic.title,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${topic.totalPhotos} ${context.lang("photos")}'
                                      .toLowerCase(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              );
            }, childCount: topics.length),
          )
        ],
      ),
    );
  }
}
