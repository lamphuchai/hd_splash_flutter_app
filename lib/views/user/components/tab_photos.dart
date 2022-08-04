// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/user/user.dart';

class TabPhotosView extends StatefulWidget {
  const TabPhotosView({Key? key}) : super(key: key);

  @override
  State<TabPhotosView> createState() => _TabPhotosViewState();
}

class _TabPhotosViewState extends State<TabPhotosView>
    with AutomaticKeepAliveClientMixin<TabPhotosView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) => previous.photos != current.photos,
      builder: (context, state) {
        return CustomMasonryGirdPhotos(
          onNotification: (scrollEnd) {
            final metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              bool isBottom = metrics.pixels == 0;
              if (!isBottom) {
                context.read<UserCubit>().nextPagePhotos();
              }
            }
            return true;
          },
          onRefresh: () async => context.read<UserCubit>().loadingPhotos(),
          photos: state.photos,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
