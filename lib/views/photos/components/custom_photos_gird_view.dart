import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/photos/photos.dart';

class PhotosGridView extends StatelessWidget {
  const PhotosGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosCubit, PhotosState>(
      buildWhen: (previous, current) => previous.photos != current.photos,
      builder: (context, state) {
        return CustomMasonryGirdPhotos(
          loadMoreData: (isLoadMore) {
            if (isLoadMore) {
              context.read<PhotosCubit>().nextPagePhotos();
            }
          },
          onRefresh: () async => context.read<PhotosCubit>().loadingPhotos(),
          photos: state.photos,
        );
      },
    );
  }
}
