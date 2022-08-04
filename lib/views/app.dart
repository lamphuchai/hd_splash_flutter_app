import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/router/app_router.dart';
import 'package:hd_splash_flutter/app/theme/my_themes.dart';
import 'package:hd_splash_flutter/logic/cubits/app_setting/app_setting_cubit.dart';
import 'package:hd_splash_flutter/logic/cubits/download/download_cubit.dart';
import 'package:hd_splash_flutter/views/home/home.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (RepositoryProvider(
      create: (context) =>
          Unsplash()..createApi("crxeLTDmsoekx_w74acFM5EZl43RC0FJd44naaAOIfo"),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppSettingCubit(),
          ),
          BlocProvider(
            create: (context) => DownloadCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      buildWhen: (previous, current) {
        if (previous.crossAxisCountGird != current.crossAxisCountGird) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          locale: state.locale,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const HomeView(),
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
