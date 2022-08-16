import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/logic/cubits/auth/auth_cubit.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

import '../current_user_profile.dart';

class CurrentUserProfileView extends StatelessWidget {
  const CurrentUserProfileView({Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthCubit>().state as Authenticated).user;
    return BlocProvider(
      create: (context) => CurrentUserProfileCubit(
          user: user, currentUserApi: context.read<Unsplash>().currentUser,collectionsApi: context.read<Unsplash>().collections)
        ..loadingDataUser(),
      child: const CurrentUserProfilePage(),
    );
  }
}
