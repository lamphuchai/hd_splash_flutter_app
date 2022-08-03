import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'detail_topic_state.dart';

class DetailTopicCubit extends Cubit<DetailTopicState> {
  DetailTopicCubit({required Topic topic, required Topics topicsApi})
      : _topicsApi = topicsApi,
        super(DetailTopicState(topic: topic));
  final Topics _topicsApi;

  Future<void> loadingPhotos() async {
    try {
      emit(state.copyWith(statusType: StatusType.loading));
      final photos = await _topicsApi.photos(idTopic: state.topic.id);
      emit(state.copyWith(photos: photos, statusType: StatusType.loaded));
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      final nextPage = state.currentIndex + 1;
      final photos =
          await _topicsApi.photos(idTopic: state.topic.id, page: nextPage);
      if (state.photos.length < state.topic.totalPhotos) {
        emit(state.copyWith(photos: [...state.photos, ...photos]));
      }
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }
}
