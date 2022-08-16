import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hd_splash_flutter/app/config/app_const.dart';
import 'package:hd_splash_flutter/core/utils/secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:uni_links/uni_links.dart';
import 'package:unsplash_dart/unsplash_dart.dart';
import 'package:url_launcher/url_launcher.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required Unsplash unsplash})
      : _unsplash = unsplash,
        super(Unauthenticated()) {
    _subscription = _unsplash.currentUser.userChange.listen((User? user) {
      if (user != null) {
        getDataUser(user);
      }
    });
    _subscriptionUni = uriLinkStream.listen((uri) {
      final code = uri!.queryParameters["code"];
      if (code != null) {
        getToken(code: code);
      }
    });
  }
  final Unsplash _unsplash;
  late StreamSubscription _subscription;
  late StreamSubscription _subscriptionUni;
  Future<void> init() async {
    final accessToken = await SecureStorage.readValue(StorageKey.accessToken);
    if (accessToken != null) {
      log(' access token ::: $accessToken');
      _unsplash.updateAuthorization(accessToken: accessToken);
      await _unsplash.currentUser.getCurrentUser();
    }
  }

  Future<void> logIn() async {
    try {
      Uri uri = Uri.parse(AppConst.urlAddAccount);
      if (await canLaunchUrl(uri)) {}
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getToken({required String code}) async {
    try {
      emit(LoadingAuth());
      final data = await _unsplash.auth.getToken(
        clientId: AppConst.clientId,
        clientSecret: AppConst.clientSecret,
        redirectUri: AppConst.redirectUri,
        code: code,
      );
      _unsplash.updateAuthorization(accessToken: data["access_token"]);
      await _unsplash.currentUser.getCurrentUser();
      await SecureStorage.writeValue(
          key: StorageKey.accessToken, value: data["access_token"]);
      await SecureStorage.writeValue(
          key: StorageKey.refreshToken, value: data["refresh_token"]);
    } catch (error) {
      emit(Unauthenticated());
      log(error.toString());
    }
  }

  Future<void> logOut() async {
    await SecureStorage.deleteAll();
    _unsplash.updateAuthorization(clientId: AppConst.clientId);
    emit(Unauthenticated());
  }

  Future<void> getDataUser(User user) async {
    try {
      final collections =
          await _unsplash.currentUser.getCollections(username: user.username);
      emit(Authenticated(user: user, collections: collections));
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    _subscriptionUni.cancel();
    return super.close();
  }
}
