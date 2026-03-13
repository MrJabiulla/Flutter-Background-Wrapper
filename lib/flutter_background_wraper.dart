/// A powerful Flutter package that provides a customizable background layout widget.
///
/// The `flutter_background_wraper` package simplifies the creation of consistent,
/// professional-looking app screens by combining app bar, background management,
/// state handling, and navigation elements into a single easy-to-use widget.
///
/// ## Key Features
///
/// - **AppBackground Widget**: Main widget with customizable styling and layout
/// - **Multiple Background Types**: Support for solid colors and image providers
/// - **State Management**: Built-in handling for loading, error, and refresh states
/// - **Flexible AppBar**: Customizable with title, back button, actions, and search
/// - **Navigation Support**: Bottom navigation bar and floating action button
/// - **Pull-to-Refresh**: Easy-to-implement refresh functionality
/// - **Safe Area Support**: Automatic safe area padding
///
/// ## Usage
///
/// ```dart
/// import 'package:flutter_background_wraper/flutter_background_wraper.dart';
///
/// // Simple usage with color background
/// AppBackground.color(
///   color: Colors.white,
///   title: 'Home',
///   child: MyContent(),
/// )
///
/// // With image background
/// AppBackground.image(
///   image: AssetImage('assets/bg.png'),
///   title: 'Profile',
///   child: MyContent(),
/// )
/// ```
library flutter_background_wrapper;

export 'src/widgets/app_background.dart';
export 'src/config/app_config.dart';
export 'src/config/app_styles.dart';
