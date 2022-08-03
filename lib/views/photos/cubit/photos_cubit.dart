import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  PhotosCubit({required Photos photosApi})
      : _photosApi = photosApi,
        super(const PhotosState());
  final Photos _photosApi;
  int _pagePhotos = 1;

  Future<void> loadingPhotos() async {
    try {
      emit(state.copyWith(status: PhotosStatus.loading));
      final photos = await _photosApi.getPhotos( perPage: 20);
      emit(state.copyWith(photos: photos, status: PhotosStatus.loaded));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: PhotosStatus.error));
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      _pagePhotos += 1;
      final photos = await _photosApi.getPhotos(
          orderBy: PhotosOrderBy.latest, page: _pagePhotos, perPage: 20);
      emit(state.copyWith(photos: [
        ...state.photos,
        ...photos,
      ]));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: PhotosStatus.error));
    }
  }
}
