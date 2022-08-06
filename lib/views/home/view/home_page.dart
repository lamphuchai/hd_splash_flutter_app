import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/config/app_assets.dart';

import '../../../logic/cubits/cubits.dart';
import '../../collections/collections.dart';
import '../../photos/photos.dart';
import '../../search/search.dart';
import '../../setting/setting.dart';
import '../../topics/topics.dart';
import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      builder: (context, homeState) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: BlocBuilder<InternetCubit, InternetState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    switch (state.status) {
                      case InternetStatus.none:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.noInternet,
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("no internet"),
                            ],
                          ),
                        );
                      case InternetStatus.internet:
                        return IndexedStack(
                            index: homeState.currentIndex,
                            children: const [
                              PhotosView(),
                              CollectionsView(),
                              TopicsView(),
                              SearchView(),
                              SettingView()
                            ]);

                      default:
                        return const SizedBox();
                    }
                  }),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            selectedIndex: homeState.currentIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.photo), label: "Photos"),
              NavigationDestination(
                  icon: Icon(Icons.collections), label: "Collections"),
              NavigationDestination(icon: Icon(Icons.topic), label: "Topics"),
              NavigationDestination(icon: Icon(Icons.search), label: "Search"),
              NavigationDestination(
                  icon: Icon(Icons.settings), label: "Setting")
            ],
            onDestinationSelected: (index) =>
                context.read<HomeCubit>().changeIndex(index),
          ),
        );
      },
    );
  }
}
