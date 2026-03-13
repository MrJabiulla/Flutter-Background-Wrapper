import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Global configuration constants for the AppBackground widget.
///
/// This class defines default values and system styling for the AppBackground widget.
/// It serves as a centralized location for configuration that can be referenced across the package.
class AppConfig {
  /// Default background color used when no explicit color or image is provided.
  static const Color backgroundColor = Colors.white;

  /// Default system UI overlay style for the status bar.
  static const SystemUiOverlayStyle statusBarStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
}
