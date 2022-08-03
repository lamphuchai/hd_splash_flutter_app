import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'collections_state.dart';

class CollectionsCubit extends Cubit<CollectionsState> {
  CollectionsCubit({required Collections collections})
      : _collectionsApi = collections,
        super(const CollectionsState());

  final Collections _collectionsApi;
  int _pageCollections = 1;

  Future<void> loadingCollections() async {
    try {
      emit(state.copyWith(status: CollectionsStatus.loading));
      final collections = await _collectionsApi.getCollections(perPage: 20);
      emit(state.copyWith(
          collections: collections, status: CollectionsStatus.loaded));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: CollectionsStatus.error));
    }
  }

  Future<void> nextPageCollections() async {
    try {
      _pageCollections += 1;
      final collections = await _collectionsApi.getCollections(
          page: _pageCollections, perPage: 20);
      emit(state.copyWith(
        collections: [...state.collections, ...collections],
      ));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: CollectionsStatus.error));
    }
  }
}
