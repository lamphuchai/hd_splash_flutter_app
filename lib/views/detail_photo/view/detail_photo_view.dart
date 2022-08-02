import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/detail_photo/detail_photo.dart';

class DetailPhotoView extends StatelessWidget {
  const DetailPhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailPhotoCubit(),
      child: const DetailPhotoPage(),
    );
  }
}
