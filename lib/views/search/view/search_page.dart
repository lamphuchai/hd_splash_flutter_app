import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  "Tìm kiếm",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              Text(
                "Hình ảnh,bộ sưa tập,chủ đề,người dùng ..",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Nhập để tìm kiếm ",
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.resultSearch,
                          arguments: context.read<SearchCubit>().state.query);
                    },
                  ),
                ),
                onChanged: (query) =>
                    context.read<SearchCubit>().onChangeQuery(query),
                // onEditingComplete: () {
                //   Navigator.pushNamed(context, RouteName.resultSearch,
                //       arguments: context.read<SearchCubit>().state.query);
                // },
                onSubmitted: (value) => Navigator.pushNamed(
                    context, RouteName.resultSearch,
                    arguments: value),
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text("Lịch sử"),
          trailing: GestureDetector(
            onTap: () => context.read<SearchCubit>().deleteAllHistory(),
            child: const Text(
              "Xoá",
              style: TextStyle(color: Colors.red),
            ),
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
                  return Wrap(
                      children: state.listHistory
                          .map(
                            (history) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
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
