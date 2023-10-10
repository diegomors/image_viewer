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
  bool hasError = false;

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

    final image = ImageElement();
    image.src = widget.src;
    image.style.width = widget.width != null ? '${widget.width!.floor()}px' : '100%';
    image.style.height = widget.height != null ? '${widget.height!.floor()}px' : '100%';
    image.style.objectFit = objectFit;

    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      widget.src,
      (int _) => image,
    );

    return AnimatedCrossFade(
      duration: const Duration(microseconds: 1),
      crossFadeState: isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: widget.loading ??
          SizedBox(
            width: widget.width ?? width,
            height: widget.height ?? height,
          ),
      secondChild: !hasError
          ? SizedBox(
              width: widget.width ?? width,
              height: widget.height ?? height,
              child: HtmlElementView(
                viewType: widget.src,
                onPlatformViewCreated: (value) {
                  if (value >= 0) {
                    isLoaded(image);
                  }
                },
              ),
            )
          : widget.error ??
              SizedBox(
                width: widget.width ?? width,
                height: widget.height ?? height,
              ),
    );
  }

  isLoaded(ImageElement image) async {
    final imageLoaded = image.complete ?? false;
    final imageShown = image.naturalHeight != 0;
    if (imageLoaded && imageShown) {
      setState(() {
        isLoading = false;
      });
    } else {
      if (!imageLoaded) {
        await Future.delayed(const Duration(seconds: 1));
        await isLoaded(image);
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    }
  }
}
