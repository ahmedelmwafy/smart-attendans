import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssetImage extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;

  const AppAssetImage({
    super.key,
    required this.path,
    required this.width,
    required this.height,
    this.fit = BoxFit.contain,
    this.color,
  });

  bool get _isSvg => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }

    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }
}