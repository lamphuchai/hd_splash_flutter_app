import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/logic/cubits/app_setting/app_setting_cubit.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class CustomMasonryGirdPhotos extends StatelessWidget {
  const CustomMasonryGirdPhotos({
    Key? key,
    required this.photos,
    required this.onRefresh,
    this.shrinkWrap = false,
    required this.loadMoreData,
  }) : super(key: key);
  final List<Photo> photos;
  final Future<void> Function() onRefresh;
  final bool shrinkWrap;

  final Function(bool) loadMoreData;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          bool isBottom = metrics.pixels == 0;
          if (!isBottom) {
            loadMoreData(true);
          }
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          buildWhen: (previous, current) {
            if ((previous.crossAxisCountGird != current.crossAxisCountGird) ||
                (previous.loadQualityType != current.loadQualityType)) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return MasonryGridView.count(
                padding: const EdgeInsets.only(top: 10),
                itemCount: photos.length,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: state.crossAxisCountGird,
                shrinkWrap: shrinkWrap,
                addAutomaticKeepAlives: true,
                itemBuilder: ((context, index) {
                  final photo = photos[index];
                  return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, RouteName.detailPhoto,
                          arguments: photo),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: context.countHeightPhoto(
                                crossAxisCount: state.crossAxisCountGird,
                                width: photo.width,
                                height: photo.height),
                            color: photo.color.converterColor,
                            child: CustomCacheNetworkImage(
                                key: ValueKey(photo.id),
                                placeholder: false,
                                fit: BoxFit.cover,
                                imageUrl:
                                    photo.urls.photoUrl(state.loadQualityType)),
                          )));
                }));
          },
        ),
      ),
    );
  }
}
