import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'collection_related_state.dart';

class CollectionRelatedCubit extends Cubit<CollectionRelatedState> {
  CollectionRelatedCubit(
      {required Collections collectionsApi, required String idCollection})
      : _collectionsApi = collectionsApi,
        _idCollection = idCollection,
        super(const CollectionRelatedState());
  final Collections _collectionsApi;
  final String _idCollection;

  Future<void> loadingCollections() async {
    try {
      emit(state.copyWith(status: StatusType.loading));
      final collections = await _collectionsApi.relatedCollectionsById(
        id: _idCollection,
      );
      emit(state.copyWith(collections: collections, status: StatusType.loaded));
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }
}
