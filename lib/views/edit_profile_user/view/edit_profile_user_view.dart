import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/logic/cubits/auth/auth_cubit.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

import '../edit_profile_user.dart';

class EditProfileUserView extends StatelessWidget {
  const EditProfileUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthCubit>().state as Authenticated).user;
    return BlocProvider(
      create: (context) => EditProfileUserCubit(user: user,currentUserApi: context.read<Unsplash>().currentUser),
      child: const EditProfileUserPage(),
    );
  }
}
