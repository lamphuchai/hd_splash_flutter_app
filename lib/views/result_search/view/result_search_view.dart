import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/views/result_search/result_search.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class ResultSearchView extends StatelessWidget {
  const ResultSearchView({Key? key, required this.query}) : super(key: key);
  final String query;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultSearchCubit(
          query: query, searchApi: context.read<Unsplash>().search)
        ..searchAll(),
      child: ResultSearchPage(
        query: query,
      ),
    );
  }
}
