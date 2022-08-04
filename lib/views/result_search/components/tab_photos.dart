// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/result_search/result_search.dart';

class TabPhotos extends StatefulWidget {
  const TabPhotos({Key? key}) : super(key: key);

  @override
  State<TabPhotos> createState() => _TabPhotosState();
}

class _TabPhotosState extends State<TabPhotos>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultSearchCubit, ResultSearchState>(
      buildWhen: (previous, current) => previous.photos != current.photos,
      builder: (context, state) {
        return CustomMasonryGirdPhotos(
          onNotification: (scrollEnd) {
            final metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              bool isBottom = metrics.pixels == 0;
              if (!isBottom) {
                context.read<ResultSearchCubit>().nextPagePhotos();
              }
            }
            return true;
          },
          onRefresh: () async {},
          photos: state.photos,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
