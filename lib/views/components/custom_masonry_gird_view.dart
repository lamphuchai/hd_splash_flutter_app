import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class CustomMasonryGirdView extends StatelessWidget {
  const CustomMasonryGirdView(
      {Key? key,
      required this.photos,
      this.onNotification,
      required this.onRefresh,
      this.crossAxisCount = 2})
      : super(key: key);
  final List<Photo> photos;
  final bool Function(ScrollEndNotification)? onNotification;
  final Future<void> Function() onRefresh;
  final int crossAxisCount;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: onNotification,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: MasonryGridView.count(
            padding: const EdgeInsets.only(top: 10),
            itemCount: photos.length,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            itemBuilder: ((context, index) {
              final photo = photos[index];
              return GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: context.countHeightPhoto(
                            crossAxisCount: 2,
                            width: photo.width,
                            height: photo.height),
                        color: photo.color.converterColor,
                        child: CustomCacheNetworkImage(
                            fit: BoxFit.cover, imageUrl: photo.urls.regular),
                      )));
            })),
      ),
    );
  }
}
