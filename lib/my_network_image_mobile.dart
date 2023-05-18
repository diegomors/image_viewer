import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_viewer/my_network_image_interface.dart';

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
            width: width,
            height: height,
            placeholderBuilder: loading != null ? (_) => loading! : null,
            // There's no error state handler
          )
        : Image.network(
            src,
            width: width,
            height: height,
            loadingBuilder: loading != null ? (_, __, ___) => ___ == null ? __ : loading! : null,
            errorBuilder: error != null ? (_, __, ___) => error! : null,
          );
  }
}
