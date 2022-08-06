import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';

import '../../components/components.dart';
import '../collections.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNestedScrollHead(
      title: context.lang("collections"),
      subtitle: context.lang("sub-collections"),
      body: BlocBuilder<CollectionsCubit, CollectionsState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case StatusType.loading:
              return const AppLoadingWidget();
            case StatusType.error:
              return const AppErrorWidget();
            case StatusType.loaded:
              return const CollectionsGirdView();
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
