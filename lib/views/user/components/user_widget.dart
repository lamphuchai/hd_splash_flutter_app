import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/user/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    maxRadius: 35,
                    backgroundImage:
                        CachedNetworkImageProvider(user.profileImage.large),
                  )),
              Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ItemTotalUser(
                        title: "Photos",
                        total: user.totalPhotos.toString(),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ItemTotalUser(
                        title: "Likes",
                        total: user.totalLikes.toString(),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ItemTotalUser(
                        title: "Collections",
                        total: user.totalCollections.toString(),
                      ),
                    ],
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          if (user.location != null) ...[
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [const Icon(Icons.place), Text(user.location!)],
            )
          ],
          if (user.bio != null) ...[
            const SizedBox(
              height: 5,
            ),
            Text(user.bio!)
          ],
          if (user.twitterUsername != null)
            Wrap(
              children: [
                const Text("Twitter : "),
                GestureDetector(
                  onTap: () async {
                    Uri url = Uri.parse(
                        'https://twitter.com/${user.twitterUsername}');
                    try {
                      if (await canLaunchUrl(url)) {}
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  child: Text(
                    '${user.twitterUsername}',
                    style: const TextStyle(color: Color(0xff3498db)),
                  ),
                )
              ],
            ),
          if (user.instagramUsername != null)
            const SizedBox(
              height: 5,
            ),
          Wrap(
            children: [
              const Text("Instagram : "),
              GestureDetector(
                onTap: () async {
                  Uri url = Uri.parse(
                      'https://www.instagram.com/${user.instagramUsername}/');
                  try {
                    if (await canLaunchUrl(url)) {}
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: Text(
                  '${user.instagramUsername}',
                  style: const TextStyle(color: Color(0xff3498db)),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

class ItemTotalUser extends StatelessWidget {
  const ItemTotalUser({Key? key, required this.title, required this.total})
      : super(key: key);
  final String title;
  final String total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(
          height: 5,
        ),
        Text(total),
      ],
    );
  }
}
