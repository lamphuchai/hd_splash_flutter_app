import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/photos/photos.dart';

class CustomPhotosGridView extends StatelessWidget {
  const CustomPhotosGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedScrollHead(
        title: "Hình ảnh",
        subtitle: "Những bức ảnh nổi bật trên unspalsh",
        body: BlocBuilder<PhotosCubit, PhotosState>(
          buildWhen: (previous, current) => previous.photos != current.photos,
          builder: (context, state) {
            return CustomMasonryGirdPhotos(
              onNotification: (scrollEnd) {
                final metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  bool isBottom = metrics.pixels == 0;
                  if (!isBottom) {
                    context.read<PhotosCubit>().nextPagePhotos();
                  }
                }
                return true;
              },
              onRefresh: () async =>
                  context.read<PhotosCubit>().loadingPhotos(),
              photos: state.photos,
            );
          },
        ));
  }
}
