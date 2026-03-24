import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class AppColors {
  AppColors._();

  // ── Brand ─────────────────────────────────────────────────────────────
  static const Color brandBlue         = Color(0xFF004687);
  static       Color brandBlueDisabled = const Color(0xFF004687).withOpacity(0.4);

  // ── Background ────────────────────────────────────────────────────────
  static const Color background        = Colors.white;
  static const Color inputFill         = Color(0xFFF5F5F5);

  // ── Text ──────────────────────────────────────────────────────────────
  static const Color textPrimary       = Color(0xFF1A1A1A);
  static const Color textSecondary     = Colors.grey;

  // ── Accents ───────────────────────────────────────────────────────────
  static const Color gold              = Color(0xFFFFD700);
  static const Color success           = Colors.green;
  static const Color error             = Colors.red;
}

class AppImage {
  AppImage._();

  static Widget file(
    File? file, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Widget? fallback,
  }) {
    final Widget placeholder = fallback ??
        const Icon(Icons.image_outlined, color: Colors.grey, size: 40);

    if (file == null) return placeholder;
    if (kIsWeb) return placeholder;

    final image = Image.file(
      file,
      width: width,
      height: height,
      fit: fit,
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: image);
    }

    return image;
  }
}