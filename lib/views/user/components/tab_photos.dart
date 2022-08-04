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
          loadMoreData: (isLoadMore) {
            if (isLoadMore) {
              context.read<UserCubit>().nextPagePhotos();
            }
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
