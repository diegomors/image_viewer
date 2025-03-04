import 'package:flutter/material.dart';

import 'my_network_image_stub.dart' if (dart.library.io) 'my_network_image_mobile.dart' if (dart.library.html) 'my_network_image_web.dart';

class MyNetworkImage extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? loading;
  final Widget? error;

  const MyNetworkImage(
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
    return MyNetworkImageImpl(
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
