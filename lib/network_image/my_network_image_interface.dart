import 'package:flutter/material.dart';

abstract class MyNetworkImageInterface {
  const MyNetworkImageInterface(
    String src, {
    double? width,
    double? height,
    BoxFit? fit,
    Widget? loading,
    Widget? error,
  });
}
