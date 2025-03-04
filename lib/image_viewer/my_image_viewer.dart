import 'package:flutter/material.dart';

import 'my_image_viewer_stub.dart' if (dart.library.io) 'my_image_viewer_mobile.dart' if (dart.library.html) 'my_image_viewer_web.dart';

class MyImageViewer extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? loading;
  final Widget? error;

  const MyImageViewer(
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
    return MyImageViewerImpl(
      src,
      key: key,
      width: width,
      height: height,
      fit: fit,
      loading: loading,
      error: error,
    );
  }
}
