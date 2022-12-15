import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    this.height,
    this.width,
    this.shape = BoxShape.rectangle,
  });

  final double? height;
  final double? width;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 8,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
        shape: shape,
      ),
    );
  }
}
