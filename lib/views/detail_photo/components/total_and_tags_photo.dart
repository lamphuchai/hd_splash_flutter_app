import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/detail_photo/detail_photo.dart';

class TotalAndTagsPhoto extends StatelessWidget {
  const TotalAndTagsPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPhotoCubit, DetailPhotoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final tags = state.dataPhoto["tags"];
        switch (state.status) {
          case StatusType.loading:
            return const LoadingWidget();
          case StatusType.loaded:
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ItemTotal(
                          title: "Views",
                          total: state.dataPhoto["views"].toString(),
                        ),
                        ItemTotal(
                          title: "Likes",
                          total: state.photo.likes.toString(),
                        ),
                        ItemTotal(
                          title: "Downloads",
                          total: state.dataPhoto["downloads"].toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tags.length,
                      itemBuilder: ((context, index) => Container(
                            margin: EdgeInsets.only(
                                left: index == 0 ? 16 : 5, right: 5),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, RouteName.resultSearch,
                                  arguments: tags[index].title),
                              child: Chip(
                                  label: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(tags[index].title),
                              )),
                            ),
                          ))),
                ),
              ],
            );
          case StatusType.error:
            return const Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
