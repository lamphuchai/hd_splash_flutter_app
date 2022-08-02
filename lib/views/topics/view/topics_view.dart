import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/topics/topics.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class TopicsView extends StatelessWidget {
  const TopicsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TopicsCubit(topics: context.read<Unsplash>().topics)..loadingTopics(),
      child: const TopicsPage(),
    );
  }
}
