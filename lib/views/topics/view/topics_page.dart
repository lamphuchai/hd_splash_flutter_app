import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/topics/topics.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedScrollHead(
      title: "Chủ để",
      subtitle: "Những chủ để trên unspalsh",
      sortChild: BlocBuilder<TopicsCubit, TopicsState>(
        buildWhen: (previous, current) => previous.orderBy != current.orderBy,
        builder: (context, state) {
          return ButtonSortOrderBy(
            listValue: OrderByTopic.values,
            selected: state.orderBy,
            onSelected: (orderBy) =>
                context.read<TopicsCubit>().changeOrderBy(orderBy),
          );
        },
      ),
      body: BlocBuilder<TopicsCubit, TopicsState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case StatusType.loading:
                  return const AppLoadingWidget();
                case StatusType.error:
                  return const AppErrorWidget();
            case StatusType.loaded:
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
