import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/router/app_router.dart';
import 'package:hd_splash_flutter/views/home/home.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (RepositoryProvider(
      create: (context) =>
          Unsplash()..createApi("crxeLTDmsoekx_w74acFM5EZl43RC0FJd44naaAOIfo"),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          splashColor: Colors.transparent,
          backgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
            splashColor: Colors.transparent, backgroundColor: Colors.black),
        home: const HomeView(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    ));
  }
}
