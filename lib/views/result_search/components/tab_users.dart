// ignore_for_file: must_call_super

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/result_search/result_search.dart';

class TabUsers extends StatefulWidget {
  const TabUsers({Key? key}) : super(key: key);

  @override
  State<TabUsers> createState() => _TabUsersState();
}

class _TabUsersState extends State<TabUsers>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultSearchCubit, ResultSearchState>(
      buildWhen: (previous, current) => previous.users != current.users,
      builder: (context, state) {
        return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: ((context, index) {
              final user = state.users[index];
              return Container(
                margin: const EdgeInsets.only(top: 8),
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RouteName.user,
                      arguments: user),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                  child: CircleAvatar(
                                maxRadius: 35,
                                backgroundImage: CachedNetworkImageProvider(
                                    user.profileImage.large),
                              )),
                            ],
                          )),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Wrap(
                                  children: [
                                    Text(
                                      user.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              );
            }));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
