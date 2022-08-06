import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'detail_collection_state.dart';

class DetailCollectionCubit extends Cubit<DetailCollectionState> {
  DetailCollectionCubit(
      {required Collection collection, required Collections collectionsApi})
      : _collectionsApi = collectionsApi,
        _collection = collection,
        super(const DetailCollectionState());

  final Collections _collectionsApi;
  final int _prePage = 20;
  int _pagePhotos = 1;
  final Collection _collection;

  Future<void> loadingPhotos() async {
    try {
      emit(state.copyWith(statusType: StatusType.loading));
      final photos = await _collectionsApi.photosInCollectionById(
          id: _collection.id, perPage: _prePage, page: _pagePhotos);
      emit(state.copyWith(photos: photos, statusType: StatusType.loaded));
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      _pagePhotos = _pagePhotos + 1;
      final photos = await _collectionsApi.photosInCollectionById(
          id: _collection.id, perPage: _prePage);
      if (state.photos.length < _collection.totalPhotos) {
        emit(state.copyWith(photos: [...state.photos, ...photos]));
      }
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }
}
