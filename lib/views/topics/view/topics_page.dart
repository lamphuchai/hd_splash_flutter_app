import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/topics/topics.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: BlocBuilder<TopicsCubit, TopicsState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case TopicsStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case TopicsStatus.error:
              return const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
              );
            case TopicsStatus.loaded:
              return const TopicsListView();
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class TopicsListView extends StatelessWidget {
  const TopicsListView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicsCubit, TopicsState>(
      buildWhen: (previous, current) => previous.topics != current.topics,
      builder: (context, state) {
        return CustomSliverListTopics(
          topics: state.topics,
        );
      },
    );
  }
}
