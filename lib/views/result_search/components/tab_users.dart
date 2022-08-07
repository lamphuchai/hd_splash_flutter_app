// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/logic/cubits/app_setting/app_setting_cubit.dart';
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
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      buildWhen: (previous, current) =>
          previous.crossAxisCountGird != current.crossAxisCountGird,
      builder: (context, appSetting) {
        return NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            final metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              bool isBottom = metrics.pixels == 0;
              if (!isBottom) {
                context.read<ResultSearchCubit>().nextPageUsers();
              }
            }
            return true;
          },
          child: BlocBuilder<ResultSearchCubit, ResultSearchState>(
            buildWhen: (previous, current) => previous.users != current.users,
            builder: (context, state) {
              if (state.users.isEmpty) {
                return Center(
                  child: Text(context.lang("no-data-result-search")),
                );
              }
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
                        onTap: () => Navigator.pushNamed(
                            context, RouteName.user,
                            arguments: user),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CustomCacheNetworkImage(
                                  height: 55,
                                  width: 55,
                                  imageUrl: user.profileImage.large),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                                    Text(context.lang("photos"))
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
                                    Text(context.lang("like"))
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
                                    Text(context.lang("collections"))
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
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
