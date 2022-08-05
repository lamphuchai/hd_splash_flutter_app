import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/photos/photos.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class CustomPhotosGridView extends StatelessWidget {
  const CustomPhotosGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedScrollHead(
        title: "Hình ảnh",
        subtitle: "Những bức ảnh nổi bật trên unspalsh",
        sortChild: BlocBuilder<PhotosCubit, PhotosState>(
          buildWhen: (previous, current) => previous.orderBy != current.orderBy,
          builder: (context, state) {
            return ButtonSortPhotos<PhotosOrderBy>(
              listValue: const [
                PhotosOrderBy.latest,
                PhotosOrderBy.oldest,
                PhotosOrderBy.popular
              ],
              value: state.orderBy,
              onSelected: (orderBy) =>
                  context.read<PhotosCubit>().changeOrderBy(orderBy),
            );
          },
        ),
        body: BlocBuilder<PhotosCubit, PhotosState>(
          buildWhen: (previous, current) => previous.photos != current.photos,
          builder: (context, state) {
            return CustomMasonryGirdPhotos(
              loadMoreData: (isLoadMore) {
                if (isLoadMore) {
                  context.read<PhotosCubit>().nextPagePhotos();
                }
              },
              onRefresh: () async =>
                  context.read<PhotosCubit>().loadingPhotos(),
              photos: state.photos,
            );
          },
        ));
  }
}
