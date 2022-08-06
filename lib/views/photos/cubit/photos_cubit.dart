import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  PhotosCubit({required Photos photosApi})
      : _photosApi = photosApi,
        super(const PhotosState());
  final Photos _photosApi;
  int _pagePhotos = 1;
  final int _prePage = 20;

  Future<void> loadingPhotos() async {
    try {
      emit(state.copyWith(status: StatusType.loading));
      final photos =
          await _photosApi.getPhotos(perPage: _prePage, orderBy: state.orderBy);
      emit(state.copyWith(photos: photos, status: StatusType.loaded));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      _pagePhotos += 1;
      final photos = await _photosApi.getPhotos(
          page: _pagePhotos, perPage: _prePage, orderBy: state.orderBy);
      emit(state.copyWith(photos: [
        ...state.photos,
        ...photos,
      ]));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> changeOrderBy(PhotosOrderBy orderBy) async {
    emit(state.copyWith(orderBy: orderBy));
    await loadingPhotos();
  }
}
