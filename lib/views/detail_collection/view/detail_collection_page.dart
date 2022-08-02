import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/detail_collection/detail_collection.dart';

class DetailCollectionPage extends StatelessWidget {
  const DetailCollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DetailCollectionCubit, DetailCollectionState>(
        builder: (context, state) {
          switch (state.statusType) {
            case StatusType.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case StatusType.loaded:
              return CustomMasonryGirdView(
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge) {
                    bool isBottom = metrics.pixels == 0;
                    if (!isBottom) {
                      // context.read<PhotosCubit>().nextPagePhotos();
                    }
                  }
                  return true;
                },
                onRefresh: () async =>
                    context.read<DetailCollectionCubit>().loadingPhotos(),
                photos: state.photos,
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
