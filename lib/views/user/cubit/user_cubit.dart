import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required User user, required Users usersApi})
      : _usersApi = usersApi,
        _user = user,
        super(const UserState());

  final Users _usersApi;
  final User _user;
  int _pagePhotos = 1;
  int _pageLikes = 1;
  int _pageCollections = 1;

  User get user => _user;
  Future<void> loadingDataUser() async {
    try {
      emit(state.copyWith(status: StatusType.loading));
      List<Future<dynamic>> listFu = [];
      UserState userState = const UserState();
      if (_user.totalPhotos != 0) {
        final photos = await _usersApi.getPhotos(username: _user.username);
        userState = userState.copyWith(photos: photos);
      }
      if (_user.totalLikes != 0) {
        final photos = await _usersApi.getLikes(username: _user.username);
        userState = userState.copyWith(likePhotos: photos);
      }
      if (_user.totalCollections != 0) {
        listFu.add(_usersApi.getCollections(username: _user.username));
        final collections =
            await _usersApi.getCollections(username: _user.username);
        userState = userState.copyWith(collections: collections);
      }
      emit(userState.copyWith(status: StatusType.loaded));
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> loadingPhotos() async {
    try {
      if (_user.totalPhotos != 0) {
        final photos = await _usersApi.getPhotos(username: _user.username);
        emit(state.copyWith(photos: photos));
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      if (state.photos.length < user.totalPhotos) {
        _pagePhotos += 1;
        final photos = await _usersApi.getPhotos(
            username: _user.username, page: _pagePhotos);
        emit(state.copyWith(photos: [...state.photos, ...photos]));
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> loadingLikePhotos() async {
    try {
      if (user.totalLikes != 0) {
        final photos = await _usersApi.getLikes(username: _user.username);
        emit(state.copyWith(likePhotos: photos));
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> nextLikePhotos() async {
    try {
      if (state.likePhotos.length < user.totalLikes) {
        _pageLikes += _pageLikes;
        final likePhotos = await _usersApi.getLikes(
            username: _user.username, page: _pageLikes);
        emit(state.copyWith(likePhotos: [...state.likePhotos, ...likePhotos]));
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> loadingCollections() async {
    try {
      if (user.totalCollections != 0) {
        final collections =
            await _usersApi.getCollections(username: _user.username);
        emit(state.copyWith(collections: collections));
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> nextCollections() async {
    try {
      if (state.collections.length < user.totalCollections) {
        _pageCollections += _pageCollections;
        final collections = await _usersApi.getCollections(
            username: _user.username, page: _pageCollections);
        emit(state
            .copyWith(collections: [...state.collections, ...collections]));
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }
}
