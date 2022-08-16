import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';
import 'package:hd_splash_flutter/core/type/enum.dart';
import 'package:hd_splash_flutter/core/utils/share_fu.dart';
import 'package:hd_splash_flutter/logic/cubits/auth/auth_cubit.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/detail_collection/cubit/detail_collection_cubit.dart';

import 'components.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCollectionCubit, DetailCollectionState>(
      buildWhen: (previous, current) =>
          previous.collection != current.collection,
      builder: (context, state) {
        bool isAdmin = false;
        final collection = state.collection;
        final isAuthenticated =
            context.read<AuthCubit>().state is Authenticated;
        if (isAuthenticated) {
          isAdmin =
              (context.read<AuthCubit>().state as Authenticated).user.id ==
                  state.collection.user.id;
        }
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              bool isTrue = context
                      .read<DetailCollectionCubit>()
                      .state
                      .actionCollection ==
                  ActionCollection.updateCollection;
              if (isTrue) {
                return Navigator.pop(context, AppAction.updateCollection);
              }
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: false,
          title: Text(
            collection.title,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            ButtonOpenUrlHtml(uri: collection.links.html),
            PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  switch (value) {
                    case "SHARE":
                      share(collection.links.html);
                      break;
                    case "EDIT":
                      final cubitPage = context.read<DetailCollectionCubit>();
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => BottomModalEditCollection(
                                title: collection.title,
                                description: collection.description ?? "",
                                private: collection.private,
                                onSubmit: (data) =>
                                    cubitPage.updateCollection(data),
                              ));
                      break;
                    case "DELETE":
                      final cubitPage = context.read<DetailCollectionCubit>();
                      showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                                contentText:
                                    "Delete collection : ${collection.title} ?",
                                onAction: () {
                                  cubitPage.deleteCollection();
                                  Navigator.pop(context);
                                },
                              ));
                      break;
                    default:
                      break;
                  }
                },
                itemBuilder: ((context) => [
                      PopupMenuItem(
                        value: "SHARE",
                        child: Row(
                          children: [
                            const Icon(
                              Icons.share,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              context.lang(LangCode.share),
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                      if (isAdmin) ...[
                        PopupMenuItem(
                          value: "EDIT",
                          child: Row(
                            children: [
                              const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                context.lang(LangCode.edit),
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: "DELETE",
                          child: Row(
                            children: [
                              const Icon(
                                Icons.delete,
                                size: 20,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                context.lang(LangCode.delete),
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    ]))
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
