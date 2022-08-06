import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/collections/collections.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CollectionsCubit(collectionsApi: context.read<Unsplash>().collections)
            ..loadingCollections(),
      child: const CollectionsPage(),
    );
  }
}
