// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';

import '../current_user_profile.dart';

class TabPhotoLikesView extends StatefulWidget {
  const TabPhotoLikesView({Key? key}) : super(key: key);

  @override
  State<TabPhotoLikesView> createState() => _TabPhotoLikesViewState();
}

class _TabPhotoLikesViewState extends State<TabPhotoLikesView>
    with AutomaticKeepAliveClientMixin<TabPhotoLikesView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserProfileCubit, CurrentUserProfileState>(
      buildWhen: (previous, current) =>
          previous.likePhotos != current.likePhotos,
      builder: (context, state) {
        return CustomMasonryGirdPhotos(
          loadMoreData: (isLoadMore) {
            if (isLoadMore) {
              context.read<CurrentUserProfileCubit>().loadLikesByPage(LoadType.page);
            }
          },
          onRefresh: () async =>
              context.read<CurrentUserProfileCubit>().loadLikesByPage(LoadType.refresh),
          photos: state.likePhotos,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
