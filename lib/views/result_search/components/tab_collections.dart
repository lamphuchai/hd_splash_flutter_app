// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/result_search/result_search.dart';

class TabCollections extends StatefulWidget {
  const TabCollections({Key? key}) : super(key: key);

  @override
  State<TabCollections> createState() => _TabCollectionsState();
}

class _TabCollectionsState extends State<TabCollections>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultSearchCubit, ResultSearchState>(
      buildWhen: (previous, current) =>
          previous.collections != current.collections,
      builder: (context, state) {
        return CustomMasonryGirdCollections(
          collections: state.collections,
          onRefresh: () async {},
          onNotification: (scrollEnd) {
            final metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              bool isBottom = metrics.pixels == 0;
              if (!isBottom) {
                context.read<ResultSearchCubit>().nextPageCollections();
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
