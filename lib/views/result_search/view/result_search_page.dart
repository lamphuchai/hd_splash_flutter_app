import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/result_search/components/components.dart';
import 'package:hd_splash_flutter/views/result_search/result_search.dart';

class ResultSearchPage extends StatelessWidget {
  const ResultSearchPage({Key? key, required this.query}) : super(key: key);
  final String query;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(query),
          bottom: TabBar(tabs: [
            Tab(
              text: context.lang("photos"),
            ),
            Tab(
              text: context.lang("collections"),
            ),
            Tab(
              text: context.lang("users"),
            )
          ]),
        ),
        body: BlocBuilder<ResultSearchCubit, ResultSearchState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            switch (state.status) {
              case StatusType.loading:
                return const AppLoadingWidget();
              case StatusType.error:
                return const AppErrorWidget();
              case StatusType.loaded:
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TabBarView(
                      children: [TabPhotos(), TabCollections(), TabUsers()]),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
