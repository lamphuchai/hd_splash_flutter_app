import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/config/app_const.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'detail_collection_state.dart';

class DetailCollectionCubit extends Cubit<DetailCollectionState> {
  DetailCollectionCubit(
      {required Collection collection, required Collections collectionsApi})
      : _collectionsApi = collectionsApi,
        super(DetailCollectionState(collection: collection));

  final Collections _collectionsApi;
  int _pagePhotos = 1;

  Future<void> loadingPhotos() async {
    if (state.collection.totalPhotos == 0) {
      emit(state.copyWith(statusType: StatusType.loaded, photos: []));
    } else {
      try {
        List<Future> listFu = [
          _collectionsApi.getPhotosByCollection(
              id: state.collection.id,
              perPage: AppConst.prePage,
              page: _pagePhotos),
          _collectionsApi.getRelatedCollections(id: state.collection.id)
        ];
        emit(state.copyWith(statusType: StatusType.loading));
        final data = await Future.wait(listFu);
        emit(state.copyWith(
            photos: data[0],
            relatedCollections: data[1],
            statusType: StatusType.loaded));
      } catch (error) {
        emit(state.copyWith(statusType: StatusType.error));
      }
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      _pagePhotos = _pagePhotos + 1;
      final photos = await _collectionsApi.getPhotosByCollection(
          id: state.collection.id, perPage: AppConst.prePage);
      if (state.photos.length < state.collection.totalPhotos) {
        emit(state.copyWith(photos: [...state.photos, ...photos]));
      }
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }

  Future<void> deleteCollection() async {
    try {
      await _collectionsApi.deleteCollection(id: state.collection.id);
      emit(state.copyWith(actionCollection: ActionCollection.deleteCollection));
    } catch (error) {
      emit(state.copyWith(actionCollection: ActionCollection.actionError));
    }
  }

  Future<void> updateCollection(Map<String, dynamic> data) async {
    try {
      final collection = await _collectionsApi.updateCollection(
          id: state.collection.id,
          title: data["title"],
          private: data["private"],
          description: data["description"]);
      emit(state.copyWith(
          collection: collection,
          actionCollection: ActionCollection.updateCollection));
    } catch (error) {
      emit(state.copyWith(actionCollection: ActionCollection.actionError));
    }
  }
}
