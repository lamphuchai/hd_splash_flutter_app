import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/photos/photos.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class PhotosView extends StatelessWidget {
  const PhotosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotosCubit(
        photosApi: context.read<Unsplash>().photos,
      ),
      child: const PhotosPage(),
    );
  }
}
