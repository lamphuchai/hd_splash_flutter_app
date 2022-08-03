import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/user/user.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserCubit(user: user, usersApi: context.read<Unsplash>().users)
            ..loadingDataUser(),
      child: UserPage(
        user: user,
      ),
    );
  }
}
