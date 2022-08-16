import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'edit_profile_user_state.dart';

class EditProfileUserCubit extends Cubit<EditProfileUserState> {
  EditProfileUserCubit(
      {required User user, required CurrentUser currentUserApi})
      : _currentUserApi = currentUserApi,
        super(EditProfileUserState.fromUser(user));
  final CurrentUser _currentUserApi;

  void onChangeUsername(String value) {
    emit(state.copyWith(username: value));
  }

  void onChangeFirstName(String value) {
    emit(state.copyWith(firstName: value));
  }

  void onChangeLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

    void onChangeEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void onChangeUrl(String value) {
    emit(state.copyWith(portfolioUrl: value));
  }

  void onChangeLocation(String value) {
    emit(state.copyWith(location: value));
  }

  void onChangeInstagramUsername(String value) {
    emit(state.copyWith(instagramUsername: value));
  }

  void onChangeBio(String value) {
    emit(state.copyWith(bio: value));
  }

  Future<void> updateProfileUser() async {
    try {
      final user = await _currentUserApi.updateCurrentUser(
          username: state.username,
          email: state.email,
          firstName: state.firstName.checkNullString,
          lastName: state.lastName.checkNullString,
          url: state.portfolioUrl.checkNullString,
          location: state.location.checkNullString,
          instagramUsername: state.instagramUsername.checkNullString,
          bio: state.bio.checkNullString);
      emit(EditProfileUserState.fromUser(user, status: Status.complete));
    } catch (error) {
      emit(state.copyWith(status: Status.err));
      log(error.toString());
    }
  }
}
