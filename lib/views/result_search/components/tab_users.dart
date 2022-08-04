// ignore_for_file: must_call_super

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/logic/cubits/app_setting/app_setting_cubit.dart';
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
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      buildWhen: (previous, current) =>
          previous.crossAxisCountGird != current.crossAxisCountGird,
      builder: (context, appSetting) {
        return BlocBuilder<ResultSearchCubit, ResultSearchState>(
          buildWhen: (previous, current) => previous.users != current.users,
          builder: (context, state) {
            return MasonryGridView.count(
                padding: const EdgeInsets.only(top: 10),
                crossAxisCount: appSetting.crossAxisCountGird,
                itemCount: state.users.length,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                itemBuilder: ((context, index) {
                  final user = state.users[index];
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey)),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RouteName.user,
                          arguments: user),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            maxRadius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                                user.profileImage.large),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            user.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    user.totalPhotos.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text("Photos")
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    user.totalLikes.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text("Likes")
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    user.totalCollections.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text("Collections")
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                }));
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
