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
        themeMode: ThemeMode.system,
        theme: ThemeData(
            // useMaterial3: true,
            primaryColor: Colors.white,
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            splashColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(color: Colors.black),
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black)),
            iconTheme: const IconThemeData(color: Colors.black)),
        darkTheme: ThemeData(
            // useMaterial3: true,
            primaryColor: Colors.white,
            backgroundColor: Colors.transparent,
            scaffoldBackgroundColor: Colors.white,
            splashColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black)),
            iconTheme: const IconThemeData(color: Colors.black)),
        home: const HomeView(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    ));
  }
}
