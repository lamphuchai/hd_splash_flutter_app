import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/config/app_const.dart';
import 'package:hd_splash_flutter/logic/cubits/auth/auth_cubit.dart';
import 'package:hd_splash_flutter/views/current_user_profile/cubit/current_user_profile_cubit.dart';
import 'package:unsplash_dart/unsplash_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/locale/app_localizations.dart';
import '../app/router/app_router.dart';
import '../app/theme/my_themes.dart';
import '../logic/cubits/cubits.dart';
import 'home/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (RepositoryProvider(
      create: (context) => Unsplash()..createApi(AppConst.clientId),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthCubit(unsplash: context.read<Unsplash>())..init(),
          ),
          BlocProvider(
            create: (context) => InternetCubit(),
          ),
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
        if ((previous.crossAxisCountGird != current.crossAxisCountGird) ||
            (previous.loadQualityType != current.loadQualityType)) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'Hd SPLASH FLUTTER',
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          locale: state.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const HomeView(),
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
