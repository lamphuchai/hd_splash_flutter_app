import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'topics_state.dart';

class TopicsCubit extends Cubit<TopicsState> {
  TopicsCubit({required Topics topics})
      : _topics = topics,
        super(const TopicsState());
  final Topics _topics;
  Future<void> loadingTopics() async {
    try {
      emit(state.copyWith(status: TopicsStatus.loading));
      final topics = await _topics.topics(perPage: 30, orderBy: state.orderBy);
      emit(state.copyWith(status: TopicsStatus.loaded, topics: topics));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: TopicsStatus.error));
    }
  }

  Future<void> changeOrderBy(OrderByTopic orderBy) async {
    emit(state.copyWith(orderBy: orderBy));
    await loadingTopics();
  }
}
