// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/user/user.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class TabLikesView extends StatefulWidget {
  const TabLikesView({Key? key}) : super(key: key);

  @override
  State<TabLikesView> createState() => _TabLikesViewState();
}

class _TabLikesViewState extends State<TabLikesView>
    with AutomaticKeepAliveClientMixin<TabLikesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) =>
            previous.likePhotos != current.likePhotos,
        builder: (context, state) {
          return CustomMasonryGirdPhotos(
            loadMoreData: (isLoadMore) {
              if (isLoadMore) {
                context.read<UserCubit>().nextLikePhotos();
              }
            },
            onRefresh: () async =>
                context.read<UserCubit>().loadingLikePhotos(),
            photos: state.likePhotos,
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
              selected: state.likesOrderBy,
              listValue: LikesPhotosOrderBy.values,
              onSelected: (orderBy) =>
                  context.read<UserCubit>().changeLikesOrderBy(orderBy),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
