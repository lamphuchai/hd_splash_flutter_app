import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/config/app_const.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/logic/cubits/auth/auth_cubit.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/setting/components/item_block.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CurrentUserWidget extends StatelessWidget {
  const CurrentUserWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.lang(LangCode.account),
          style: textTheme.titleLarge,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(16)),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is LoadingAuth) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: AppLoadingWidget(
                      size: 40,
                    ),
                  );
                } else if (state is Authenticated) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 20, right: 25),
                      childrenPadding:
                          const EdgeInsets.only(left: 25, right: 20),
                      iconColor: Theme.of(context).iconTheme.color,
                      collapsedIconColor: Theme.of(context).iconTheme.color,
                      leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: CachedNetworkImageProvider(
                              state.user.profileImage.large)),
                      title: Text(
                        state.user.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        state.user.email ?? "",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ItemBlock(
                          title: context.lang(LangCode.viewProfile),
                          icon: const Icon(Icons.info),
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteName.currentUserProfile,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ItemBlock(
                          title: context.lang(LangCode.editProfile),
                          icon: const Icon(Icons.edit),
                          onTap: () => Navigator.pushNamed(
                              context, RouteName.editProfileUser),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ItemBlock(
                          title: context.lang(LangCode.logOut),
                          icon: const Icon(Icons.cancel),
                          onTap: () => context.read<AuthCubit>().logOut(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: ItemBlock(
                          title: context.lang(LangCode.addAccount),
                          icon: const Icon(Icons.person_add),
                          onTap: () async => context.read<AuthCubit>().logIn(),
                        ),
                      ),
                    ],
                  );
                }
              },
            )),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class LoginWebView extends StatefulWidget {
  const LoginWebView({Key? key}) : super(key: key);

  @override
  State<LoginWebView> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  double webProgress = 0;
  late WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: [
          IconButton(
              onPressed: () async {
                _webViewController.reload();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (await _webViewController.canGoBack()) {
            _webViewController.goBack();
            return false;
          }
          return true;
        },
        child: Column(
          children: [
            webProgress < 1
                ? SizedBox(
                    height: 2,
                    child: LinearProgressIndicator(
                      value: webProgress,
                      color: Colors.red,
                      backgroundColor: Colors.transparent,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: WebView(
                gestureNavigationEnabled: true,
                initialUrl: AppConst.urlAddAccount,
                onProgress: (value) =>
                    setState(() => webProgress = value / 100),
                onWebViewCreated: (controller) =>
                    _webViewController = controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
