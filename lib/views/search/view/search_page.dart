import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/views/search/cubit/search_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
          child: Wrap(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  context.lang("search"),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              Text(
                context.lang("sub-search"),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: context.lang("input-search"),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      final query = context.read<SearchCubit>().state.query;
                      if (query.isNotEmpty) {
                        context.read<SearchCubit>().onSaveHistory();
                        Navigator.pushNamed(context, RouteName.resultSearch,
                            arguments: context.read<SearchCubit>().state.query);
                      }
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                onChanged: (query) =>
                    context.read<SearchCubit>().onChangeQuery(query),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    context.read<SearchCubit>().onSaveHistory();
                    Navigator.pushNamed(context, RouteName.resultSearch,
                        arguments: value);
                  }
                },
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(context.lang("history")),
          trailing: IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () => context.read<SearchCubit>().deleteAllHistory(),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              child: BlocBuilder<SearchCubit, SearchState>(
                buildWhen: (previous, current) =>
                    previous.listHistory != current.listHistory,
                builder: (context, state) {
                  if (state.listHistory.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          context.lang("try-search"),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  }
                  return Wrap(
                      children: state.listHistory
                          .map(
                            (history) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteName.resultSearch,
                                    arguments: history),
                                child: Chip(
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Text(history),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList());
                },
              )),
        ))
      ],
    );
  }
}
