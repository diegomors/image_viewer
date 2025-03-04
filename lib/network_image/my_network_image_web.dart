// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart';

import 'my_network_image_interface.dart';

@JS('Image')
@staticInterop
class JSImageElement {
  external factory JSImageElement();
}

extension JSImageElementExtension on JSImageElement {
  external set src(String value);
  external int get naturalHeight;
  external bool get complete;
}

class MyNetworkImageImpl extends StatefulWidget implements MyNetworkImageInterface {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? loading;
  final Widget? error;

  MyNetworkImageImpl(this.src, {super.key, this.width, this.height, this.fit, this.loading, this.error})
      : assert(
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

    // Create JS ImageElement
    final image = JSImageElement();
    image.src = widget.src;

    final imageId = '${widget.key}-${widget.src}';

    // Register the view factory for the image
    ui_web.platformViewRegistry.registerViewFactory(imageId, (int _) {
      final img = document.createElement('img') as HTMLElement;
      img.setAttribute('src', widget.src);
      img.style
        ..width = widget.width != null ? '${widget.width!.floor()}px' : '100%'
        ..height = widget.height != null ? '${widget.height!.floor()}px' : '100%'
        ..objectFit = objectFit;

      return img;
    });

    return AnimatedCrossFade(
      duration: const Duration(microseconds: 1),
      crossFadeState: isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: widget.loading ?? const CircularProgressIndicator(),
      secondChild: !hasError
          ? SizedBox(
              width: widget.width ?? width,
              height: widget.height ?? height,
              child: HtmlElementView(
                key: widget.key,
                viewType: imageId,
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

  isLoaded(JSImageElement image) async {
    final imageLoaded = image.complete;
    final imageShown = image.naturalHeight != 0;
    if (imageLoaded && imageShown) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (!imageLoaded) {
        await Future.delayed(const Duration(seconds: 1));
        await isLoaded(image);
      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
            hasError = true;
          });
        }
      }
    }
  }
}
