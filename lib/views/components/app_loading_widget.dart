import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key, this.size}) : super(key: key);
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitCircle(
      color: Colors.teal,
      size: size ?? 50.0,
    ));
  }
}
