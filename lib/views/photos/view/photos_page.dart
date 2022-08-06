import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

import '../photos.dart';
import '../../components/components.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedScrollHead(
        title: "Hình ảnh",
        subtitle: "Những bức ảnh nổi bật trên unspalsh",
        sortChild: BlocBuilder<PhotosCubit, PhotosState>(
          buildWhen: (previous, current) => previous.orderBy != current.orderBy,
          builder: (context, state) {
            return ButtonSortOrderBy(
              listValue: PhotosOrderBy.values,
              selected: state.orderBy,
              onSelected: (orderBy) =>
                  context.read<PhotosCubit>().changeOrderBy(orderBy),
            );
          },
        ),
        body: BlocBuilder<PhotosCubit, PhotosState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: ((context, state) {
              switch (state.status) {
                case StatusType.loading:
                  return const AppLoadingWidget();
                case StatusType.error:
                  return const AppErrorWidget();
                case StatusType.loaded:
                  return const PhotosGridView();
                default:
                  return const SizedBox();
              }
            })));
  }
}
