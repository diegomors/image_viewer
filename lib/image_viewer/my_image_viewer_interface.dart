import 'package:flutter/material.dart';

abstract class MyImageViewerInterface {
  const MyImageViewerInterface(
    String src, {
    double? width,
    double? height,
    BoxFit? fit,
    Widget? loading,
    Widget? error,
  });
}
