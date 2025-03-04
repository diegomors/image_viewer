import 'package:flutter/material.dart';

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
    throw UnimplementedError('Stub Implementation');
  }
}
