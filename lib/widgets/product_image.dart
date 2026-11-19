import 'package:flutter/material.dart';

/// Menampilkan gambar produk dari asset lokal (assets/...) atau dari URL (http...).
class ProductImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: width,
      height: height,
      color: const Color(0xFFFFEBEE),
      child: const Center(
        child: Icon(Icons.settings, color: Color(0xFFB71C1C), size: 40),
      ),
    );

    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => fallback,
      );
    }

    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}