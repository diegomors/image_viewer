import 'package:flutter/material.dart';

import '../network_image/network_image.dart';

class MyCustomSlider extends StatefulWidget {
  final String url;
  final Color lineColor;
  final Color pointColor;
  final Function(int) onChange;

  const MyCustomSlider(
    this.url, {
    super.key,
    required this.lineColor,
    required this.pointColor,
    required this.onChange,
  });

  @override
  State<MyCustomSlider> createState() => _MyCustomSliderState();
}

class _MyCustomSliderState extends State<MyCustomSlider> {
  int size = 5;
  int? middle;
  int? selected;
  double thumbSize = 50;
  double lineHeight = 15;
  double lineWidth = 300;
  double pointSize = 10;

  @override
  void initState() {
    super.initState();
    middle = (size / 2).floor();
    selected = middle;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thumbSize,
      width: lineWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Line
          Container(
            height: lineHeight,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: widget.lineColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          // Point
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                size,
                (index) => Container(
                  height: pointSize,
                  width: pointSize,
                  margin: index == 0
                      ? const EdgeInsets.only(left: 4)
                      : index == size - 1
                          ? const EdgeInsets.only(right: 4)
                          : null,
                  decoration: BoxDecoration(
                    color: widget.pointColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          // Thumb
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              size,
              (index) => index == selected
                  ? MyNetworkImage(
                      widget.url,
                      key: ValueKey(widget.url),
                      width: thumbSize,
                      height: thumbSize,
                      fit: BoxFit.scaleDown,
                      loading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.pointColor,
                        ),
                        width: thumbSize,
                        height: thumbSize,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(
                            color: widget.lineColor,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                      error: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.pointColor,
                        ),
                        width: thumbSize,
                        height: thumbSize,
                      ),
                    )
                  : InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      onTap: () => setState(() {
                        selected = index;
                        widget.onChange(selected!);
                      }),
                      child: SizedBox(
                        width: thumbSize,
                        height: thumbSize,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
