import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/logic/cubits/download/download_cubit.dart';
import 'package:hd_splash_flutter/views/components/components.dart';

import 'package:hd_splash_flutter/views/detail_photo/detail_photo.dart';

class DetailPhotoPage extends StatelessWidget {
  const DetailPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DownloadCubit, DownloadState>(
      listener: (context, state) {
        switch (state.status) {
          case DownloadStatus.start:
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Bắt đầu tải")));
            break;
          case DownloadStatus.complete:
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Tải thành công")));
            break;
          case DownloadStatus.error:
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Tải lỗi")));
            break;
          default:
            break;
        }
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
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
                              ),
                              trailing: IconButton(
                                  onPressed: () => context
                                      .read<DownloadCubit>()
                                      .downloadPhoto(state.photo),
                                  icon: const Icon(
                                    Icons.download,
                                  )),
                              onTap: () => Navigator.pushNamed(
                                  context, RouteName.user,
                                  arguments: state.photo.user),
                            );
                          },
                        ),
                        const ExifPhoto(),
                        const Expanded(child: TotalAndTagsPhoto())
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}
