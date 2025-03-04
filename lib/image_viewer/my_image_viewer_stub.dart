import 'package:flutter/material.dart';

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
    throw UnimplementedError('Stub Implementation');
  }
}
