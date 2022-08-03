// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/user/user.dart';

class TabLikesView extends StatefulWidget {
  const TabLikesView({Key? key}) : super(key: key);

  @override
  State<TabLikesView> createState() => _TabLikesViewState();
}

class _TabLikesViewState extends State<TabLikesView>
    with AutomaticKeepAliveClientMixin<TabLikesView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          previous.likePhotos != current.likePhotos,
      builder: (context, state) {
        return CustomMasonryGirdView(
          onNotification: (scrollEnd) {
            final metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              bool isBottom = metrics.pixels == 0;
              if (!isBottom) {
                context.read<UserCubit>().nextLikePhotos();
              }
            }
            return true;
          },
          onRefresh: () async => context.read<UserCubit>().loadingLikePhotos(),
          photos: state.likePhotos,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
