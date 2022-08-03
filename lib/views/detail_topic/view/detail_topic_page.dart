import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/detail_topic/detail_topic.dart';

import '../../components/custom_masonry_gird_view.dart';

class DetailTopicPage extends StatelessWidget {
  const DetailTopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DetailTopicCubit, DetailTopicState>(
        builder: (context, state) {
          switch (state.statusType) {
            case StatusType.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case StatusType.loaded:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CustomMasonryGirdView(
                  onNotification: (scrollEnd) {
                    final metrics = scrollEnd.metrics;
                    if (metrics.atEdge) {
                      bool isBottom = metrics.pixels == 0;
                      if (!isBottom) {
                        context.read<DetailTopicCubit>().nextPagePhotos();
                      }
                    }
                    return true;
                  },
                  onRefresh: () async =>
                      context.read<DetailTopicCubit>().loadingPhotos(),
                  photos: state.photos,
                ),
              );
            case StatusType.error:
              return const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
