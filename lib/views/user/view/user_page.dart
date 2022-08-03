import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/user/user.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    List<Map> tabs = [];
    if (user.totalPhotos != 0) {
      tabs.add({"tab": const TabPhotosView(), "title": "photos"});
    }
    if (user.totalLikes != 0) {
      tabs.add({"tab": const TabLikesView(), "title": "likes"});
    }
    if (user.totalCollections != 0) {
      tabs.add({"tab": const TabCollectionsView(), "title": "collections"});
    }
    return Scaffold(
        appBar: AppBar(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.orange,
                  height: 100,
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Sliver Grid Header',
                      style: TextStyle(fontSize: 28)),
                ),
              ),
            ];
          },
          body: DefaultTabController(
            length: tabs.length,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 40,
                  width: double.infinity,
                  child: TabBar(
                    indicatorColor: Colors.teal,
                    labelColor: Colors.black,
                    tabs: tabs
                        .map((tab) => Tab(
                              text: tab["title"],
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<UserCubit, UserState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      switch (state.status) {
                        case StatusType.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case StatusType.error:
                          return const Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red,
                          );
                        case StatusType.loaded:
                          return TabBarView(
                            children: tabs
                                .map((tab) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: tab["tab"],
                                    ))
                                .toList(),
                          );
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}


//  BlocBuilder<UserCubit, UserState>(
//             builder: (context, state) {
//               switch (state.status) {
//                 case StatusType.loading:
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 case StatusType.error:
//                   return const Icon(
//                     Icons.error_outline_rounded,
//                     color: Colors.red,
//                   );
//                 case StatusType.loaded:
//                   return const SizedBox();
//                 default:
//                   return const SizedBox();
//               }
//             },
//           ),