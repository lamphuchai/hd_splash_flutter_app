import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/config/app_assets.dart';
import 'package:hd_splash_flutter/logic/cubits/internet/internet_cubit.dart';
import 'package:hd_splash_flutter/views/collections/view/collections_view.dart';
import 'package:hd_splash_flutter/views/home/home.dart';
import 'package:hd_splash_flutter/views/photos/photos.dart';
import 'package:hd_splash_flutter/views/search/search.dart';
import 'package:hd_splash_flutter/views/setting/setting.dart';
import 'package:hd_splash_flutter/views/topics/topics.dart';

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
                    previous.isConnection != current.isConnection,
                builder: (context, state) {
                  if (state.isConnection) {
                    return IndexedStack(
                        index: homeState.currentIndex,
                        children: const [
                          PhotosView(),
                          CollectionsView(),
                          TopicsView(),
                          SearchView(),
                          SettingView()
                        ]);
                  }
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
                        Text("no internet"),
                      ],
                    ),
                  );
                },
              ),
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
