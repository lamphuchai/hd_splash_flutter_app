import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

import 'components.dart';

class CustomSliverCollections extends StatelessWidget {
  const CustomSliverCollections({
    Key? key,
    required this.collections,
    this.onNotification,
    required this.onRefresh,
  }) : super(key: key);
  final List<Collection> collections;
  final bool Function(ScrollEndNotification)? onNotification;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: onNotification,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final collection = collections[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Stack(children: [
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: collection.coverPhoto?.color.converterColor,
                            child: CustomCacheNetworkImage(
                              imageUrl: collection.coverPhoto!.urls.regular,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    collection.title,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${collection.totalPhotos} photos',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  collection.user.name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                );
              },
              childCount: collections.length,
            ),
          ),
        ]),
      ),
    );
  }
}
