import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/detail_photo/detail_photo.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class DetailPhotoView extends StatelessWidget {
  const DetailPhotoView({Key? key, required this.photo}) : super(key: key);
  final Photo photo;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailPhotoCubit(
          photo: photo, photos: context.read<Unsplash>().photos)
        ..loadingExifPhoto(),
      child: const DetailPhotoPage(),
    );
  }
}
