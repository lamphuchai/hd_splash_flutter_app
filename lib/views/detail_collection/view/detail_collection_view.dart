import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

import '../detail_collection.dart';

class DetailCollectionView extends StatelessWidget {
  const DetailCollectionView({Key? key, required this.collection})
      : super(key: key);
  final Collection collection;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCollectionCubit(
          collection: collection,
          collections: context.read<Unsplash>().collections)
        ..loadingPhotos(),
      child:  DetailCollectionPage(collection: collection,),
    );
  }
}
