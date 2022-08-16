import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/config/app_const.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'current_user_profile_state.dart';

class CurrentUserProfileCubit extends Cubit<CurrentUserProfileState> {
  CurrentUserProfileCubit(
      {required User user,
      required CurrentUser currentUserApi,
      required Collections collectionsApi})
      : _currentUser = currentUserApi,
        _collectionsApi = collectionsApi,
        _user = user,
        super(const CurrentUserProfileState());
  final User _user;
  final CurrentUser _currentUser;
  final Collections _collectionsApi;
  int _pagePhotos = 1;
  int _pageLikes = 1;
  int _pageCollections = 1;

  Future<void> loadingDataUser() async {
    try {
      emit(state.copyWith(statusType: StatusType.loading));
      List<Future> fus = [
        _currentUser.getPhotos(
            username: _user.username, perPage: AppConst.prePage),
        _currentUser.getLikesPhotos(
            username: _user.username, perPage: AppConst.prePage),
        _currentUser.getCollections(
            username: _user.username, perPage: AppConst.prePage),
        _currentUser.getCurrentUser()
      ];
      final data = await Future.wait(fus);
      emit(state.copyWith(
        photos: data[0],
        likePhotos: data[1],
        collections: data[2],
        statusType: StatusType.loaded,
      ));
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
      log(error.toString());
    }
  }

  Future<void> loadPhotos(LoadType loadType) async {
    try {
      switch (loadType) {
        case LoadType.refresh:
          _pagePhotos = 1;
          final photos = await _currentUser.getLikesPhotos(
              username: _user.username,
              page: _pagePhotos,
              perPage: AppConst.prePage);
          emit(state.copyWith(photos: photos));
          break;
        case LoadType.page:
          final lengthRest = _user.totalPhotos - state.photos.length;
          if (lengthRest != 0) {
            if (lengthRest < AppConst.prePage) {
              _pagePhotos += 1;
              final photos = await _currentUser.getLikesPhotos(
                  username: _user.username,
                  page: _pagePhotos,
                  perPage: lengthRest);
              emit(state.copyWith(photos: [...state.photos, ...photos]));
            } else {
              _pagePhotos += 1;
              final photos = await _currentUser.getLikesPhotos(
                  username: _user.username,
                  page: AppConst.prePage,
                  perPage: lengthRest);
              emit(state.copyWith(photos: [...state.photos, ...photos]));
            }
          }
          break;
        default:
          break;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> loadLikesByPage(LoadType loadType) async {
    try {
      switch (loadType) {
        case LoadType.refresh:
          _pageLikes = 1;
          final data = await _currentUser.getLikesPhotos(
              username: _user.username,
              page: _pageLikes,
              perPage: AppConst.prePage);
          emit(state.copyWith(likePhotos: data));
          break;
        case LoadType.page:
          final lengthRest = _user.totalLikes - state.likePhotos.length;
          if (lengthRest != 0) {
            if (lengthRest < 20) {
              _pageLikes += 1;
              final data = await _currentUser.getLikesPhotos(
                  username: _user.username,
                  page: _pageLikes,
                  perPage: lengthRest);
              final likePhotos = [...state.likePhotos, ...data];
              emit(state.copyWith(likePhotos: likePhotos));
            } else {
              _pageLikes += 1;
              final data = await _currentUser.getLikesPhotos(
                  username: _user.username,
                  page: _pageLikes,
                  perPage: AppConst.prePage);
              final likePhotos = [...state.likePhotos, ...data];
              emit(state.copyWith(likePhotos: likePhotos));
            }
          }
          break;
        default:
          break;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> loadCollections(LoadType loadType) async {
    try {
      switch (loadType) {
        case LoadType.refresh:
          _pageCollections = 1;
          final collections = await _currentUser.getCollections(
              username: _user.username,
              page: _pageCollections,
              perPage: AppConst.prePage);
          emit(state.copyWith(collections: collections));
          break;
        case LoadType.page:
          final lengthRest = _user.totalCollections - state.collections.length;
          if (lengthRest != 0) {
            if (lengthRest < AppConst.prePage) {
              _pageCollections += 1;
              final collections = await _currentUser.getCollections(
                  username: _user.username,
                  page: _pageCollections,
                  perPage: lengthRest);
              emit(state.copyWith(
                  collections: [...state.collections, ...collections]));
            } else {
              _pageCollections += 1;
              final collections = await _currentUser.getCollections(
                  username: _user.username,
                  page: _pageCollections,
                  perPage: AppConst.prePage);
              emit(state.copyWith(
                  collections: [...state.collections, ...collections]));
            }
          }
          break;
        default:
          break;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> createCollection(Map<String, dynamic> parameters) async {
    try {
      final collection = await _collectionsApi.createCollection(
          title: parameters["title"],
          description: parameters["description"],
          private: parameters["private"]);
      emit(state.copyWith(collections: [
        collection,
        ...state.collections,
      ]));
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
