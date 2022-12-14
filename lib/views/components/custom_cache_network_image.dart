import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  const CustomCacheNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.fit,
      this.width,
      this.height,
      this.placeholder = true})
      : super(key: key);
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: fit,
      placeholder: placeholder
          ? (context, url) => const Center(
                  child: SpinKitRotatingCircle(
                color: Colors.white54,
                size: 50.0,
              ))
          : null,
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error),
      ),
      imageUrl: imageUrl,
    );
  }
}
