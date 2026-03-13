import 'package:flutter/material.dart';

/// Predefined text styles and widgets used throughout the AppBackground widget.
///
/// This class contains constants for consistent styling across the package,
/// ensuring a uniform look and feel in AppBackground components.
class AppStyles {
  /// Default text style for app bar titles.
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.2,
  );

  /// Default back button icon displayed in the app bar.
  static const Widget backIcon = Icon(
    Icons.arrow_back,
    size: 24,
    color: Colors.black,
  );
}
