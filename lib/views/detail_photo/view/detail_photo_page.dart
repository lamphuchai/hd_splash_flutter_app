import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/detail_photo/components/exif_photo.dart';
import 'package:hd_splash_flutter/views/detail_photo/cubit/detail_photo_cubit.dart';

class DetailPhotoPage extends StatelessWidget {
  const DetailPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            BlocSelector<DetailPhotoCubit, DetailPhotoState, String>(
              selector: (state) {
                return state.photo.links.html;
              },
              builder: (context, uri) {
                return ButtonOpenUrlHtml(
                  uri: uri,
                );
              },
            )
          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: BlocBuilder<DetailPhotoCubit, DetailPhotoState>(
                    buildWhen: (previous, current) =>
                        previous.photo != current.photo,
                    builder: (context, state) {
                      return Stack(fit: StackFit.expand, children: [
                        if (state.photo.blurHash != null) ...[
                          BlurHash(
                            hash: state.photo.blurHash!,
                            imageFit: BoxFit.cover,
                          )
                        ],
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RouteName.fullPhoto,
                              arguments: state.photo.urls.regular),
                          child: CustomCacheNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: state.photo.urls.regular),
                        ),
                      ]);
                    },
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<DetailPhotoCubit, DetailPhotoState>(
                        builder: (context, state) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  state.photo.user.profileImage.medium),
                            ),
                            title: Text(
                              state.photo.user.name,
                              style: const TextStyle(color: Colors.black),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.black,
                                )),
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.user,
                                arguments: state.photo.user),
                          );
                        },
                      ),
                      const ExifPhoto(),
                      Expanded(child: _tmp())
                    ],
                  )),
            ],
          ),
        ));
  }

  BlocBuilder<DetailPhotoCubit, DetailPhotoState> _tmp() {
    return BlocBuilder<DetailPhotoCubit, DetailPhotoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final tags = state.dataPhoto["tags"];
        switch (state.status) {
          case StatusType.loading:
            return const Center(
                child: SpinKitCircle(
              color: Colors.teal,
              size: 50.0,
            ));
          case StatusType.loaded:
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ItemTotal(
                          title: "Views",
                          total: state.dataPhoto["views"].toString(),
                        ),
                        ItemTotal(
                          title: "Likes",
                          total: state.photo.likes.toString(),
                        ),
                        ItemTotal(
                          title: "Downloads",
                          total: state.dataPhoto["downloads"].toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tags.length,
                      itemBuilder: ((context, index) => Container(
                            margin: EdgeInsets.only(
                                left: index == 0 ? 16 : 5, right: 5),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, RouteName.resultSearch,
                                  arguments: tags[index].title),
                              child: Chip(
                                  label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(tags[index].title),
                              )),
                            ),
                          ))),
                ),
              ],
            );
          case StatusType.err:
            return const Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
