import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/views/current_user_profile/current_user_profile.dart';
import 'package:hd_splash_flutter/views/detail_collection/detail_collection.dart';
import 'package:hd_splash_flutter/views/detail_photo/detail_photo.dart';
import 'package:hd_splash_flutter/views/detail_topic/view/detail_topic_view.dart';
import 'package:hd_splash_flutter/views/edit_profile_user/edit_profile_user.dart';
import 'package:hd_splash_flutter/views/full_photo/full_photo.dart';
import 'package:hd_splash_flutter/views/result_search/result_search.dart';
import 'package:hd_splash_flutter/views/user/user.dart';
import 'package:page_transition/page_transition.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteName.detailPhoto:
        if (args != null && args is Photo) {
          return PageTransition(
              child: DetailPhotoView(
                photo: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.fullPhoto:
        if (args != null && args is String) {
          return PageTransition(
              child: FullPhotoPage(imageUrl: args),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.detailCollection:
        if (args != null && args is Collection) {
          return PageTransition(
              child: DetailCollectionView(
                collection: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.detailTopic:
        if (args != null && args is Topic) {
          return PageTransition(
              child: DetailTopicView(
                topic: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.user:
        if (args != null && args is User) {
          return PageTransition(
              child: UserView(
                user: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();

      case RouteName.resultSearch:
        if (args != null && args is String) {
          return PageTransition(
              child: ResultSearchView(
                query: args,
              ),
              type: PageTransitionType.rightToLeft);
        }
        return _errRoute();
      case RouteName.currentUserProfile:
        return PageTransition(
            child: const CurrentUserProfileView(),
            type: PageTransitionType.rightToLeft);
      case RouteName.editProfileUser:
        return PageTransition(
            child: const EditProfileUserView(),
            type: PageTransitionType.rightToLeft);
      default:
        return _errRoute();
    }
  }

  static Route<dynamic> _errRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(title: const Text("No route")),
              body: const Center(
                child: Text("no route"),
              ),
            ));
  }
}
