import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'detail_collection_state.dart';

class DetailCollectionCubit extends Cubit<DetailCollectionState> {
  DetailCollectionCubit(
      {required Collection collection, required Collections collections})
      : _collections = collections,
        super(DetailCollectionState(collection: collection));

  final Collections _collections;
  final int _prePage = 20;

  Future<void> loadingPhotos() async {
    try {
      emit(state.copyWith(statusType: StatusType.loading));
      final photos = await _collections.photosInCollectionById(
          id: state.collection.id, perPage: _prePage);
      emit(state.copyWith(photos: photos, statusType: StatusType.loaded));
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      final nextPage = state.currentIndex + 1;
      final photos = await _collections.photosInCollectionById(
          id: state.collection.id, page: nextPage, perPage: _prePage);
      if (state.photos.length < state.collection.totalPhotos) {
        emit(state.copyWith(photos: [...state.photos, ...photos]));
      }
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }
}
