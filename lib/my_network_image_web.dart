// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'my_network_image_interface.dart';

class MyNetworkImageImpl extends StatefulWidget implements MyNetworkImageInterface {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? loading;
  final Widget? error;

  MyNetworkImageImpl(
    this.src, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.loading,
    this.error,
  }) : assert(
            fit == null || [BoxFit.fill, BoxFit.contain, BoxFit.cover, BoxFit.none, BoxFit.scaleDown].contains(fit), 'BoxFit value is not accepted');

  @override
  State<MyNetworkImageImpl> createState() => _MyNetworkImageImplState();
}

class _MyNetworkImageImplState extends State<MyNetworkImageImpl> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final objectFit = {
          BoxFit.fill: 'fill',
          BoxFit.contain: 'contain',
          BoxFit.cover: 'cover',
          BoxFit.none: 'none',
          BoxFit.scaleDown: 'scale-down',
        }[widget.fit] ??
        'contain';

    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      widget.src,
      (int _) => ImageElement()
        ..src = widget.src
        ..style.width = widget.width != null ? '${widget.width!.floor()}px' : '100%'
        ..style.height = widget.height != null ? '${widget.height!.floor()}px' : '100%'
        ..style.objectFit = objectFit,
    );
    return SizedBox(
      width: widget.width ?? width,
      height: widget.height ?? height,
      child: AnimatedCrossFade(
        duration: const Duration(microseconds: 1),
        crossFadeState: isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: widget.loading ?? const SizedBox(),
        secondChild: HtmlElementView(
          viewType: widget.src,
          onPlatformViewCreated: (value) {
            if (value >= 0) {
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
      ),
    );
  }
}
