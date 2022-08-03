
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/detail_collection/detail_collection.dart';

class DetailCollectionPage extends StatelessWidget {
  const DetailCollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title:
            BlocSelector<DetailCollectionCubit, DetailCollectionState, String>(
          selector: (state) {
            return state.collection.title;
          },
          builder: (context, title) {
            return Text(
              title,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
      ),
      body: BlocBuilder<DetailCollectionCubit, DetailCollectionState>(
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
                        context.read<DetailCollectionCubit>().nextPagePhotos();
                      }
                    }
                    return true;
                  },
                  onRefresh: () async =>
                      context.read<DetailCollectionCubit>().loadingPhotos(),
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