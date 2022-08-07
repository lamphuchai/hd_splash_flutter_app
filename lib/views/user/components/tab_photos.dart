// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/user/user.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class TabPhotosView extends StatefulWidget {
  const TabPhotosView({Key? key}) : super(key: key);

  @override
  State<TabPhotosView> createState() => _TabPhotosViewState();
}

class _TabPhotosViewState extends State<TabPhotosView>
    with AutomaticKeepAliveClientMixin<TabPhotosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
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
      ),
      floatingActionButton: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(40)),
        child: BlocBuilder<UserCubit, UserState>(
          buildWhen: (previous, current) =>
              previous.photosOrderBy != current.photosOrderBy,
          builder: (context, state) {
            return ButtonSortOrderBy(
              selected: state.photosOrderBy,
              listValue:OrderBy.values,
              onSelected: (orderBy) =>
                  context.read<UserCubit>().changePhotosOrderBy(orderBy),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
