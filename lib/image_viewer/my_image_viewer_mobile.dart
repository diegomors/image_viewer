import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'my_image_viewer_interface.dart';

class MyImageViewerImpl extends StatelessWidget implements MyImageViewerInterface {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? loading;
  final Widget? error;

  const MyImageViewerImpl(
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
    return src.toLowerCase().startsWith('http')
        ? src.toLowerCase().endsWith('svg')
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
              )
        : Image.file(
            File(src),
            key: key,
            width: width,
            height: height,
            frameBuilder: loading != null ? (ctx, wdg, chunk, _) => chunk == null ? wdg : loading! : null,
            errorBuilder: error != null ? (ctx, obj, stack) => error! : null,
          );
  }
}
