import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/detail_topic/detail_topic.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class DetailTopicView extends StatelessWidget {
  const DetailTopicView({Key? key, required this.topic}) : super(key: key);
  final Topic topic;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailTopicCubit(
          topic: topic, topicsApi: context.read<Unsplash>().topics)
        ..loadingPhotos(),
      child:  DetailTopicPage(topic: topic,),
    );
  }
}
