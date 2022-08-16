// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/current_user_profile/current_user_profile.dart';

class TabCollectionsView extends StatefulWidget {
  const TabCollectionsView({Key? key}) : super(key: key);

  @override
  State<TabCollectionsView> createState() => _TabCollectionsViewState();
}

class _TabCollectionsViewState extends State<TabCollectionsView>
    with AutomaticKeepAliveClientMixin<TabCollectionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CurrentUserProfileCubit, CurrentUserProfileState>(
        buildWhen: (previous, current) =>
            previous.collections != current.collections,
        builder: (context, state) {
          return CustomMasonryGirdCollections(
            collections: state.collections,
            loadMoreData: (isLoadMore) {
              if (isLoadMore) {
                context
                    .read<CurrentUserProfileCubit>()
                    .loadCollections(LoadType.page);
              }
            },
            actionDeleteCollection: (appAction) {
              switch (appAction) {
                case AppAction.deleteCollection:
                  context
                      .read<CurrentUserProfileCubit>()
                      .loadCollections(LoadType.refresh);
                  break;
                case AppAction.updateCollection:
                  context
                      .read<CurrentUserProfileCubit>()
                      .loadCollections(LoadType.refresh);
                  break;
                default:
                  break;
              }
            },
            onRefresh: () async => context
                .read<CurrentUserProfileCubit>()
                .loadCollections(LoadType.refresh),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final tmp = context.read<CurrentUserProfileCubit>();
          showModalBottomSheet(
              context: context,
              builder: (context) => BottomModalCreateCollection(
                    onSubmit: (parameters) => tmp.createCollection(parameters),
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
