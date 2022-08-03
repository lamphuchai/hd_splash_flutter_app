// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/result_search/result_search.dart';

class TabUsers extends StatefulWidget {
  const TabUsers({Key? key}) : super(key: key);

  @override
  State<TabUsers> createState() => _TabUsersState();
}

class _TabUsersState extends State<TabUsers>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultSearchCubit, ResultSearchState>(
      buildWhen: (previous, current) => previous.users != current.users,
      builder: (context, state) {
        return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: ((context, index) {
              final user = state.users[index];
              return Container(
                margin: const EdgeInsets.only(top: 5),
                height: 150,
                color: Colors.red,
                child: CustomCacheNetworkImage(
                  imageUrl: user.profileImage.large,
                  fit: BoxFit.cover,
                ),
              );
            }));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
