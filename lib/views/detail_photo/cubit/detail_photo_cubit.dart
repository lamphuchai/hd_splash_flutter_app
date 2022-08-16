import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'detail_photo_state.dart';

class DetailPhotoCubit extends Cubit<DetailPhotoState> {
  DetailPhotoCubit({required Photo photo, required Unsplash unsplash})
      : _unsplash = unsplash,
        super(DetailPhotoState(photo: photo));
  final Unsplash _unsplash;
  Future<void> loadingExifPhoto() async {
    try {
      emit(state.copyWith(status: StatusType.loading));
      final photo = await _unsplash.photos.getPhotoById(id: state.photo.id);
      emit(state.copyWith(status: StatusType.loaded, photo: photo));
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
      log(error.toString());
    }
  }

  Future<void> actionLikePhoto(bool like) async {
    if (like) {
      await _unsplash.photos.likePhoto(id: state.photo.id);
      emit(state.copyWith(photo: state.photo.copyWith(likedByUser: true)));
    } else {
      await _unsplash.photos.unlikePhoto(id: state.photo.id);
      emit(state.copyWith(photo: state.photo.copyWith(likedByUser: false)));
    }
  }

  Future<void> addPhotoInCollection(String collectionId) async {
    try {
      final data = await _unsplash.collections.addPhotoCollection(
          collectionId: collectionId, photoId: state.photo.id);
      final photo = Photo.fromMap(data["photo"]);

      emit(state.copyWith(
          photo: state.photo
              .copyWith(currentUserCollections: photo.currentUserCollections)));
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> removePhotoInCollection(String collectionId) async {
    try {
      final data = await _unsplash.collections.removePhotoCollection(
          collectionId: collectionId, photoId: state.photo.id);
      final photo = Photo.fromMap(data["photo"]);
      emit(state.copyWith(
          photo: state.photo
              .copyWith(currentUserCollections: photo.currentUserCollections)));
    } catch (error) {
      log(error.toString());
    }
  }
}
