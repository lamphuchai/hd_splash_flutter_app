// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/user/user.dart';

class TabCollectionsView extends StatefulWidget {
  const TabCollectionsView({Key? key}) : super(key: key);

  @override
  State<TabCollectionsView> createState() => _TabCollectionsViewState();
}

class _TabCollectionsViewState extends State<TabCollectionsView>
    with AutomaticKeepAliveClientMixin<TabCollectionsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) => previous.photos != current.photos,
      builder: (context, state) {
        return CustomMasonryGirdCollections(
          collections: state.collections,
          onRefresh: () async => context.read<UserCubit>().loadingCollections(),
          onNotification: (scrollEnd) {
            final metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              bool isBottom = metrics.pixels == 0;
              if (!isBottom) {
                context.read<UserCubit>().nextCollections();
              }
            }
            return true;
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
