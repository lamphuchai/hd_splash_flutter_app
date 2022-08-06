import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/detail_photo/detail_photo.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class ExifPhoto extends StatelessWidget {
  const ExifPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPhotoCubit, DetailPhotoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AnimatedContainer(
          height: state.status == StatusType.loaded ? 160 : 0,
          duration: const Duration(milliseconds: 200),
          child: Builder(builder: (context) {
            if (state.status == StatusType.loaded) {
              Exif exif = state.dataPhoto["exif"];
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(context.lang("camera")),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.model.toString())
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Text(context.lang("aperture")),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.aperture != null
                                ? 'f/${exif.aperture}'
                                : "Unknown")
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(context.lang("focal-length")),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.focalLength.toString())
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Text(context.lang("shutter-speed")),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.exposureTime ?? "Unknown")
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(context.lang("ios")),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.isoSpeedEatings ?? "Unknown")
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Text(context.lang("dimensions")),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('${state.photo.height}x${state.photo.width}')
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          }),
        );
      },
    );
  }
}
