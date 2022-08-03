import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

import '../../../core/type/enum.dart';

part 'result_search_state.dart';

class ResultSearchCubit extends Cubit<ResultSearchState> {
  ResultSearchCubit({required String query, required Search searchApi})
      : _query = query,
        _searchApi = searchApi,
        super(const ResultSearchState());
  final String _query;
  final Search _searchApi;
  int _pagePhotos = 1;
  int _pageUsers = 1;
  int _pageCollections = 1;

  Future<void> searchAll() async {
    try {
      emit(state.copyWith(status: StatusType.loading));
      List<Future<dynamic>> listFuture = [
        _searchApi.photos(query: _query),
        _searchApi.collections(query: _query),
        _searchApi.users(query: _query),
      ];

      final result = await Future.wait(listFuture);
      emit(state.copyWith(
          photos: result[0],
          collections: result[1],
          users: result[2],
          status: StatusType.loaded));
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      _pagePhotos += _pagePhotos;
      final photos = await _searchApi.photos(query: _query, page: _pagePhotos);
      emit(state.copyWith(photos: [...state.photos, ...photos]));
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> nextPageCollections() async {
    try {
      _pageCollections += _pageCollections;
      final collections =
          await _searchApi.collections(query: _query, page: _pageCollections);
      emit(state.copyWith(collections: [...state.collections, ...collections]));
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> nextPageUsers() async {
    try {
      _pageUsers += _pageUsers;
      final users = await _searchApi.users(query: _query, page: _pageUsers);
      emit(state.copyWith(users: [...state.users, ...users]));
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }
}
