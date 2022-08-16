// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';

import '../current_user_profile.dart';

class TabPhotosView extends StatefulWidget {
  const TabPhotosView({Key? key}) : super(key: key);

  @override
  State<TabPhotosView> createState() => _TabPhotosViewState();
}

class _TabPhotosViewState extends State<TabPhotosView>
    with AutomaticKeepAliveClientMixin<TabPhotosView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserProfileCubit, CurrentUserProfileState>(
      buildWhen: (previous, current) => previous.photos != current.photos,
      builder: (context, state) {
        return CustomMasonryGirdPhotos(
          loadMoreData: (isLoadMore) {
            if (isLoadMore) {
              context.read<CurrentUserProfileCubit>().loadPhotos(LoadType.page);
            }
          },
          onRefresh: () async => context
              .read<CurrentUserProfileCubit>()
              .loadPhotos(LoadType.refresh),
          photos: state.photos,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
