import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/logic/cubits/auth/auth_cubit.dart';
import 'package:hd_splash_flutter/logic/cubits/download/download_cubit.dart';
import 'package:hd_splash_flutter/views/components/components.dart';

import 'package:hd_splash_flutter/views/detail_photo/detail_photo.dart';

class DetailPhotoPage extends StatelessWidget {
  const DetailPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DownloadCubit, DownloadState>(
          listener: (context, state) {
            switch (state.status) {
              case DownloadStatus.start:
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(context.lang(LangCode.downloadStarted)));
                break;
              case DownloadStatus.complete:
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(context.lang(LangCode.downloadComplete)));
                break;
              case DownloadStatus.error:
                ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(context.lang(LangCode.downloadErr)));
                break;
              default:
                break;
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(context.lang(LangCode.addSuccess)));
            }
          },
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Builder(builder: (context) {
                    final photo = context.read<DetailPhotoCubit>().state.photo;
                    return Stack(fit: StackFit.expand, children: [
                      if (photo.blurHash != null) ...[
                        BlurHash(
                          hash: photo.blurHash!,
                          imageFit: BoxFit.cover,
                        )
                      ],
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, RouteName.fullPhoto,
                            arguments: photo.urls.regular),
                        child: CustomCacheNetworkImage(
                            fit: BoxFit.cover,
                            placeholder: false,
                            imageUrl: photo.urls.regular),
                      ),
                    ]);
                  })),
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
                            trailing: Wrap(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: state.photo.likedByUser
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    final authenticated = context
                                        .read<AuthCubit>()
                                        .state is Authenticated;
                                    if (authenticated) {
                                      context
                                          .read<DetailPhotoCubit>()
                                          .actionLikePhoto(
                                              !state.photo.likedByUser);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const NotificationDialog());
                                    }
                                  },
                                ),
                                IconButton(
                                    onPressed: () => context
                                        .read<DownloadCubit>()
                                        .downloadPhoto(state.photo),
                                    icon: const Icon(
                                      Icons.download,
                                    ))
                              ],
                            ),
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
        ),
      ),
    );
  }
}
