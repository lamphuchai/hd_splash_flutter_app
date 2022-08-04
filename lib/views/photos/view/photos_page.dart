import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/photos/photos.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PhotosCubit, PhotosState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: ((context, state) {
            switch (state.status) {
              case PhotosStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PhotosStatus.error:
                return const Center(
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  ),
                );
              case PhotosStatus.loaded:
                return const CustomPhotosGridView();
              default:
                return const SizedBox();
            }
          })),
    );
  }
}
