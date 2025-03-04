import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'my_network_image_interface.dart';

class MyNetworkImageImpl extends StatelessWidget implements MyNetworkImageInterface {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? loading;
  final Widget? error;

  const MyNetworkImageImpl(
    this.src, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.loading,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return src.toLowerCase().endsWith('svg')
        ? SvgPicture.network(
            src,
            key: key,
            width: width,
            height: height,
            placeholderBuilder: loading != null ? (_) => loading! : null,
            // There's no error state handler
          )
        : Image.network(
            src,
            key: key,
            width: width,
            height: height,
            loadingBuilder: loading != null ? (ctx, wdg, chunk) => chunk == null ? wdg : loading! : null,
            errorBuilder: error != null ? (ctx, obj, stack) => error! : null,
          );
  }
}
