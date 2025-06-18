// ignore_for_file: avoid_classes_with_only_static_members
import 'dart:ui';

abstract class AppImageFilters {
  static final ImageFilter blurLow = ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0);
  static final ImageFilter blurHigh = ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
}
