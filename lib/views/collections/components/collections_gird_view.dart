import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../collections.dart';

class CollectionsGirdView extends StatelessWidget {
  const CollectionsGirdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionsCubit, CollectionsState>(
      buildWhen: (previous, current) =>
          previous.collections != current.collections,
      builder: (context, state) {
        return CustomMasonryGirdCollections(
          collections: state.collections,
          onRefresh: () async =>
              context.read<CollectionsCubit>().loadingCollections(),
          loadMoreData: (isLoadMore) {
            if (isLoadMore) {
              context.read<CollectionsCubit>().nextPageCollections();
            }
          },
        );
      },
    );
  }
}