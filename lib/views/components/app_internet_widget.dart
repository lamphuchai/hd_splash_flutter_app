import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/config/app_assets.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/logic/cubits/cubits.dart';

class AppInternetWidget extends StatelessWidget {
  const AppInternetWidget({Key? key, required this.child,required this.reload})
      : super(key: key);
  final Widget child;
  final ValueChanged<bool> reload;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state.status == InternetStatus.internet) reload(true);
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == InternetStatus.internet) {
            return child;
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.noInternet,
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(context.lang("no-internet")),
                ],
              ),
            );
          }
        });
  }
}
