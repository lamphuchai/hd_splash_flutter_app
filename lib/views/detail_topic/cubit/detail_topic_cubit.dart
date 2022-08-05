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
  final int _prePage = 20;
  int _page = 1;

  Future<void> loadingPhotos() async {
    try {
      emit(state.copyWith(statusType: StatusType.loading));
      final photos = await _topicsApi.photos(
          idTopic: state.topic.id,
          perPage: _prePage,
          page: _page,
          orderBy: state.photosOrderBy);
      emit(state.copyWith(photos: photos, statusType: StatusType.loaded));
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      _page += 1;
      final photos = await _topicsApi.photos(
          idTopic: state.topic.id,
          page: _page,
          perPage: _prePage,
          orderBy: state.photosOrderBy);
      if (state.photos.length < state.topic.totalPhotos) {
        emit(state.copyWith(photos: [...state.photos, ...photos]));
      }
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }

  Future<void> changeOrderBy(TopicPhotosOrderBy orderBy) async {
    emit(state.copyWith(photosOrderBy: orderBy));
    await loadingPhotos();
  }
}
