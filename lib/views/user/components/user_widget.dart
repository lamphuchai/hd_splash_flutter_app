import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
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
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomCacheNetworkImage(
                          imageUrl: user.profileImage.large)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ItemTotal(
                  title: "Photos",
                  total: user.totalPhotos.toString(),
                ),
                const SizedBox(
                  width: 20,
                ),
                ItemTotal(
                  title: "Likes",
                  total: user.totalLikes.toString(),
                ),
                const SizedBox(
                  width: 20,
                ),
                ItemTotal(
                  title: "Collections",
                  total: user.totalCollections.toString(),
                ),
              ],
            ),
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
          if (user.instagramUsername != null) ...[
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
          ],
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
