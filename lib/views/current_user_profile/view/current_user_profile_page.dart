import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/logic/cubits/auth/auth_cubit.dart';
import 'package:hd_splash_flutter/views/components/components.dart';

import '../current_user_profile.dart';

class CurrentUserProfilePage extends StatelessWidget {
  const CurrentUserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthCubit>().state as Authenticated).user;
    List<Map> tabs = [];
    if (user.totalPhotos != 0) {
      tabs.add({"tab": const TabPhotosView(), "title": "photos"});
    }
    if (user.totalLikes != 0) {
      tabs.add({"tab": const TabPhotoLikesView(), "title": "like"});
    }
    if (user.totalCollections != 0) {
      tabs.add({"tab": const TabCollectionsView(), "title": "collections"});
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          title: Text(user.username),
          actions: [
            ButtonOpenUrlHtml(uri: user.links.html),
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RouteName.editProfileUser),
                icon: const Icon(Icons.edit))
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previous, current) => current is Authenticated,
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return UserProfileWidget(
                        user: state.user,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ];
          },
          body: DefaultTabController(
            length: tabs.length,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  tabs: tabs
                      .map((tab) => Tab(
                            text: context.lang(tab["title"]),
                          ))
                      .toList(),
                ),
                Expanded(child: BlocBuilder<CurrentUserProfileCubit,
                    CurrentUserProfileState>(
                  builder: (context, state) {
                    switch (state.statusType) {
                      case StatusType.loading:
                        return const AppLoadingWidget();
                      case StatusType.error:
                        return const AppErrorWidget();
                      case StatusType.loaded:
                        return TabBarView(
                          children: tabs
                              .map((tab) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: tab["tab"],
                                  ))
                              .toList(),
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                ))
              ],
            ),
          ),
        ));
  }
}
