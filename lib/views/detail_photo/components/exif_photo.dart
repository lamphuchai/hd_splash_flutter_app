import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                            const Text("camera"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.model.toString())
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            const Text("aperture"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.apertureValue ?? "Unknown")
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
                            const Text("focalLength"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.focalLength.toString())
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            const Text("shutterSpeed"),
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
                            const Text("ios"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.isoSpeedEatings ?? "Unknown")
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            const Text("aperture"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(exif.apertureValue ?? "Unknown")
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
