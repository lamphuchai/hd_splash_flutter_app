import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/config/app_const.dart';
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
        final photos = await _usersApi.getPhotos(
            username: _user.username, perPage: AppConst.prePage);
        userState = userState.copyWith(photos: photos);
      }
      if (_user.totalLikes != 0) {
        final photos = await _usersApi.getLikesPhotos(
            username: _user.username, perPage: AppConst.prePage);
        userState = userState.copyWith(likePhotos: photos);
      }
      if (_user.totalCollections != 0) {
        listFu.add(_usersApi.getCollections(
            username: _user.username, perPage: AppConst.prePage));
        final collections = await _usersApi.getCollections(
            username: _user.username, perPage: AppConst.prePage);
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
        final photos = await _usersApi.getPhotos(
            username: _user.username,
            perPage: AppConst.prePage,
            orderBy: state.photosOrderBy);
        emit(state.copyWith(photos: photos));
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> nextPagePhotos() async {
    try {
      final lengthRest = user.totalPhotos - state.photos.length;
      if (lengthRest > 0) {
        if (lengthRest < AppConst.prePage) {
          _pagePhotos += 1;
          final photos = await _usersApi.getPhotos(
              username: _user.username,
              page: _pagePhotos,
              perPage: lengthRest,
              orderBy: state.photosOrderBy);
          emit(state.copyWith(photos: [...state.photos, ...photos]));
        } else {
          _pagePhotos += 1;
          final photos = await _usersApi.getPhotos(
              username: _user.username,
              page: _pagePhotos,
              perPage: AppConst.prePage,
              orderBy: state.photosOrderBy);
          emit(state.copyWith(photos: [...state.photos, ...photos]));
        }
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> changePhotosOrderBy(UserOrderBy orderBy) async {
    emit(state.copyWith(photosOrderBy: orderBy));
    await loadingPhotos();
  }

  Future<void> loadingLikePhotos() async {
    try {
      if (user.totalLikes != 0) {
        final photos = await _usersApi.getLikesPhotos(
            username: _user.username,
            perPage: AppConst.prePage,
            orderBy: state.likesOrderBy);
        emit(state.copyWith(likePhotos: photos));
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> changeLikesOrderBy(LikesPhotosOrderBy orderBy) async {
    emit(state.copyWith(likesOrderBy: orderBy));
    await loadingLikePhotos();
  }

  Future<void> nextLikePhotos() async {
    try {
      final lengthRest = user.totalLikes - state.likePhotos.length;
      if (lengthRest > 0) {
        if (lengthRest < AppConst.prePage) {
          _pageLikes += _pageLikes;
          final likePhotos = await _usersApi.getLikesPhotos(
              username: _user.username, page: _pageLikes, perPage: lengthRest);
          emit(
              state.copyWith(likePhotos: [...state.likePhotos, ...likePhotos]));
        } else {
          _pageLikes += _pageLikes;
          final likePhotos = await _usersApi.getLikesPhotos(
              username: _user.username,
              page: _pageLikes,
              perPage: AppConst.prePage);
          emit(
              state.copyWith(likePhotos: [...state.likePhotos, ...likePhotos]));
        }
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> loadingCollections() async {
    try {
      if (user.totalCollections != 0) {
        final collections = await _usersApi.getCollections(
            username: _user.username, perPage: AppConst.prePage);
        emit(state.copyWith(collections: collections));
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }

  Future<void> nextCollections() async {
    try {
      final lengthRest = user.totalCollections - state.collections.length;
      if (lengthRest > 0) {
        if (lengthRest < AppConst.prePage) {
          _pageCollections += _pageCollections;
          final collections = await _usersApi.getCollections(
              username: _user.username,
              page: _pageCollections,
              perPage: lengthRest);
          emit(state
              .copyWith(collections: [...state.collections, ...collections]));
        } else {
          _pageCollections += _pageCollections;
          final collections = await _usersApi.getCollections(
              username: _user.username,
              page: _pageCollections,
              perPage: AppConst.prePage);
          emit(state
              .copyWith(collections: [...state.collections, ...collections]));
        }
      }
    } catch (error) {
      emit(state.copyWith(status: StatusType.error));
    }
  }
}
