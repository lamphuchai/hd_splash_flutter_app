import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/collections/collections.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/components/custom_masonry_gird_collections.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionsCubit, CollectionsState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        switch (state.status) {
          case CollectionsStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case CollectionsStatus.error:
            return const Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
            );
          case CollectionsStatus.loaded:
            return const ListViewCollections();
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class ListViewCollections extends StatelessWidget {
  const ListViewCollections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedScrollHead(
      title: "Bộ sưa tập",
      subtitle: "Những Bộ sưa tập nổi bật trên unspalsh",
      body: BlocBuilder<CollectionsCubit, CollectionsState>(
        buildWhen: (previous, current) =>
            previous.collections != current.collections,
        builder: (context, state) {
          return CustomMasonryGirdCollections(
            collections: state.collections,
            onRefresh: () async =>
                context.read<CollectionsCubit>().loadingCollections(),
            onNotification: (scrollEnd) {
              final metrics = scrollEnd.metrics;
              if (metrics.atEdge) {
                bool isBottom = metrics.pixels == 0;
                if (!isBottom) {
                  context.read<CollectionsCubit>().nextPageCollections();
                }
              }
              return true;
            },
          );
        },
      ),
    );
  }
}
