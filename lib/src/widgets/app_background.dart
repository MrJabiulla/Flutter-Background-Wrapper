// lib/widgets/app_background.dart

import '../helpers/platform_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_config.dart';
import '../config/app_styles.dart';


/// A widget that provides a customizable background and app bar for your application screens.
///
/// [AppBackground] wraps its child widget with an app bar, handles loading and error states,
/// supports pull-to-refresh, custom actions, a floating action button, bottom navigation, and
/// status bar customization. It is designed to streamline the creation of consistent page
/// layouts throughout your app.
class AppBackground extends StatelessWidget {
  /// Creates an [AppBackground] widget.
  ///
  /// The [title] and [child] parameters are required.
  /// Use the optional parameters to customize the appearance and behavior.
  const AppBackground({
    super.key,

    /// The title displayed in the app bar.
    required this.title,

    /// The main content of the page.
    required this.child,

    /// A custom widget to display as the app bar title instead of [title].
    this.titleWidget,

    /// Whether to show the back button in the app bar.
    this.showBackButton = true,

    /// Callback when the back button is pressed. Defaults to Navigator.maybePop().
    this.onBackPressed,

    /// List of widgets to display as action buttons in the app bar.
    this.actions,

    /// Widget to display as the bottom navigation bar.
    this.bottomNavigationBar,

    /// Widget to display as the floating action button.
    this.floatingActionButton,

    /// Custom background image for the app. If provided, it will be displayed behind the content.
    this.backgroundImage,

    /// The background color of the scaffold.
    this.backgroundColor,

    /// Custom background color for the app. Defaults to [AppConfig.backgroundColor].
    this.appBarColor,

    /// Whether to enable pull-to-refresh on the child content.
    this.isRefresh = false,

    /// Callback when a pull-to-refresh is triggered. Required if [isRefresh] is true.
    this.onRefresh,

    /// Whether to display a loading overlay.
    this.isLoading = false,

    /// Custom widget to display instead of the default loading indicator.
    this.loadingWidget,

    /// Whether to display an error overlay.
    this.isError = false,

    /// Message to display when an error occurs.
    this.errorMessage,

    /// Callback when the retry button is pressed after an error.
    this.onRetry,

    /// Whether to wrap the page content with a [SafeArea].
    this.useSafeArea = true,

    /// Whether the child content should be scrollable.
    this.isChildScrollable = true,

    /// A custom leading widget to display in the app bar instead of the back button.
    this.leading,

    /// Custom height for the app bar.
    this.appBarHeight,

    /// Custom status bar color.
    this.statusBarColor,

    /// Custom status bar brightness (light/dark).
    this.statusBarBrightness,
  });

  /// The title displayed in the app bar.
  final String title;

  /// The main content of the page.
  final Widget child;

  /// A custom widget to display as the app bar title instead of [title].
  final Widget? titleWidget;

  /// Whether to show the back button in the app bar.
  final bool showBackButton;

  /// Callback when the back button is pressed. Defaults to Navigator.maybePop().
  final VoidCallback? onBackPressed;

  /// List of widgets to display as action buttons in the app bar.
  final List<Widget>? actions;

  /// Widget to display as the bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// Widget to display as the floating action button.
  final Widget? floatingActionButton;

  /// The background color of the scaffold.
  final Color? backgroundColor;

  /// Custom background image for the app. If provided, it will be displayed behind the content.
  final ImageProvider? backgroundImage;

  /// Custom background color for the app. Defaults to [AppConfig.backgroundColor].
  final Color? appBarColor;

  /// Whether to enable pull-to-refresh on the child content.
  final bool isRefresh;

  /// Callback when a pull-to-refresh is triggered. Required if [isRefresh] is true.
  final Future<void> Function()? onRefresh;

  /// Whether to display a loading overlay.
  final bool isLoading;

  /// Custom widget to display instead of the default loading indicator.
  final Widget? loadingWidget;

  /// Whether to display an error overlay.
  final bool isError;

  /// Message to display when an error occurs.
  final String? errorMessage;

  /// Callback when the retry button is pressed after an error.
  final VoidCallback? onRetry;

  /// Whether to wrap the page content with a [SafeArea].
  final bool useSafeArea;

  /// Whether the child content should be scrollable.
  final bool isChildScrollable;

  /// A custom leading widget to display in the app bar instead of the back button.
  final Widget? leading;

  /// Custom height for the app bar.
  final double? appBarHeight;

  /// Custom status bar color.
  final Color? statusBarColor;

  /// Custom status bar brightness (light/dark).
  final Brightness? statusBarBrightness;

  @override
  Widget build(BuildContext context) {
    final double topPadding = appBarHeight ??
        (isIOS()
            ? (MediaQuery.of(context).size.width > 700 ? 30.0 : 60.0)
            : 48.0);

    final Widget body = Column(
      children: [
        SizedBox(height: topPadding),
        _buildAppBar(context),
        Expanded(
          child: isRefresh
              ? RefreshIndicator(
            onRefresh: onRefresh!,
            child: _buildChildContent(),
          )
              : _buildChildContent(),
        ),
      ],
    );

    // Apply status bar style
    SystemChrome.setSystemUIOverlayStyle(
      statusBarColor != null || statusBarBrightness != null
          ? SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? Colors.transparent,
        statusBarIconBrightness: statusBarBrightness ?? Brightness.dark,
      )
          : AppConfig.statusBarStyle,
    );

    return Scaffold(
      // Remove backgroundColor from Scaffold, handle it in the Stack for more flexibility.
      body: Stack(
        children: [
          // Background image layer (if provided)
          if (backgroundImage != null)
            Positioned.fill(
              child: Image(
                image: backgroundImage!,
                fit: BoxFit.cover,
              ),
            ),
          // Background color layer (covers the whole screen)
          Positioned.fill(
            child: Container(
              color: backgroundColor ?? AppConfig.backgroundColor,
            ),
          ),
          // Main content (with optional SafeArea)
          useSafeArea ? SafeArea(top: false, child: body) : body,
          // Loading overlay
          if (isLoading)
            Positioned.fill(
              child: loadingWidget ??
                  const Center(child: CircularProgressIndicator()),
            ),
          // Error overlay
          if (isError) _buildErrorView(context),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  /// Builds the content area, wrapping in a [SingleChildScrollView] if [isChildScrollable] is true.
  Widget _buildChildContent() {
    return isChildScrollable
        ? SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: child,
    )
        : child;
  }

  /// Builds the app bar section with optional back button, custom leading widget, title, and actions.
  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: appBarColor ?? Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (showBackButton)
            GestureDetector(
              onTap: onBackPressed ?? () => Navigator.of(context).maybePop(),
              child: AppStyles.backIcon,
            )
          else if (leading != null)
            leading!,
          if (showBackButton || leading != null) const SizedBox(width: 12),
          titleWidget ??
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.titleTextStyle,
                ),
              ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }

  /// Builds the error overlay view displayed when [isError] is true.
  Widget _buildErrorView(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorMessage ?? 'Something went wrong.',
              style: const TextStyle(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
