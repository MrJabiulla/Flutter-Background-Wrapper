// lib/widgets/app_background.dart

import '../helpers/platform_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_config.dart';
import '../config/app_styles.dart';

/// Defines how the background of [AppBackground] is rendered.
enum _BackgroundType { color, image }

/// A widget that provides a customizable background and app bar for your application screens.
///
/// [AppBackground] wraps its child widget with an app bar, handles loading and error states,
/// supports pull-to-refresh, custom actions, a floating action button, bottom navigation, and
/// status bar customization. It is designed to streamline the creation of consistent page
/// layouts throughout your app.
///
/// ## Named Constructors
///
/// Use the named constructors to set the background declaratively:
///
/// ```dart
/// // Solid color background
/// AppBackground.color(
///   color: Colors.white,
///   child: MyPage(),
/// )
///
/// // Image background (asset, network, file — any [ImageProvider])
/// AppBackground.image(
///   image: AssetImage('assets/bg.png'),
///   child: MyPage(),
/// )
/// ```
class AppBackground extends StatelessWidget {
  // ─── Default Constructor (no background — uses AppConfig.backgroundColor) ──

  /// Creates an [AppBackground] with the default background from [AppConfig.backgroundColor].
  ///
  /// To set an explicit background use [AppBackground.color] or [AppBackground.image].
  const AppBackground({
    super.key,
    required this.child,
    this.title = '',
    this.titleWidget,
    this.showBackButton = false,
    this.onBackPressed,
    this.leading,
    this.showNotification = false,
    this.onNotificationPressed,
    this.notificationBadgeCount,
    this.showSearch = false,
    this.onSearchPressed,
    this.showCall = false,
    this.onCallPressed,
    this.showOptions = false,
    this.optionMenuItems,
    this.onOptionSelected,
    this.actions,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBarColor,
    this.appBarHeight,
    this.isRefresh = false,
    this.onRefresh,
    this.isLoading = false,
    this.loadingWidget,
    this.isError = false,
    this.errorMessage,
    this.onRetry,
    this.useSafeArea = true,
    this.isChildScrollable = true,
    this.statusBarColor,
    this.statusBarBrightness,
  })  : _backgroundType = null,
        backgroundColor = null,
        backgroundImage = null;

  // ─── Named Constructor: color ───────────────────────────────────────────────

  /// Creates an [AppBackground] with a solid [color] as the background.
  ///
  /// ```dart
  /// AppBackground.color(
  ///   color: Colors.blue.shade50,
  ///   child: MyPage(),
  /// )
  /// ```
  const AppBackground.color({
    super.key,
    required Color color,
    required this.child,
    this.title = '',
    this.titleWidget,
    this.showBackButton = false,
    this.onBackPressed,
    this.leading,
    this.showNotification = false,
    this.onNotificationPressed,
    this.notificationBadgeCount,
    this.showSearch = false,
    this.onSearchPressed,
    this.showCall = false,
    this.onCallPressed,
    this.showOptions = false,
    this.optionMenuItems,
    this.onOptionSelected,
    this.actions,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBarColor,
    this.appBarHeight,
    this.isRefresh = false,
    this.onRefresh,
    this.isLoading = false,
    this.loadingWidget,
    this.isError = false,
    this.errorMessage,
    this.onRetry,
    this.useSafeArea = true,
    this.isChildScrollable = true,
    this.statusBarColor,
    this.statusBarBrightness,
  })  : _backgroundType = _BackgroundType.color,
        backgroundColor = color,
        backgroundImage = null;

  // ─── Named Constructor: image ───────────────────────────────────────────────

  /// Creates an [AppBackground] with an [image] displayed behind all content.
  ///
  /// Accepts any [ImageProvider] — asset, network, memory, or file:
  ///
  /// ```dart
  /// // Asset image
  /// AppBackground.image(
  ///   image: AssetImage('assets/background.png'),
  ///   child: MyPage(),
  /// )
  ///
  /// // Network image
  /// AppBackground.image(
  ///   image: NetworkImage('https://example.com/bg.jpg'),
  ///   child: MyPage(),
  /// )
  /// ```
  const AppBackground.image({
    super.key,
    required ImageProvider image,
    required this.child,
    this.title = '',
    this.titleWidget,
    this.showBackButton = false,
    this.onBackPressed,
    this.leading,
    this.showNotification = false,
    this.onNotificationPressed,
    this.notificationBadgeCount,
    this.showSearch = false,
    this.onSearchPressed,
    this.showCall = false,
    this.onCallPressed,
    this.showOptions = false,
    this.optionMenuItems,
    this.onOptionSelected,
    this.actions,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBarColor,
    this.appBarHeight,
    this.isRefresh = false,
    this.onRefresh,
    this.isLoading = false,
    this.loadingWidget,
    this.isError = false,
    this.errorMessage,
    this.onRetry,
    this.useSafeArea = true,
    this.isChildScrollable = true,
    this.statusBarColor,
    this.statusBarBrightness,
  })  : _backgroundType = _BackgroundType.image,
        backgroundImage = image,
        backgroundColor = null;

  // ─── Background ────────────────────────────────────────────────────────────

  /// Internal discriminator — null means fall back to [AppConfig.backgroundColor].
  final _BackgroundType? _backgroundType;

  /// The solid color used when constructed via [AppBackground.color].
  final Color? backgroundColor;

  /// The image provider used when constructed via [AppBackground.image].
  final ImageProvider? backgroundImage;

  // ─── Required ──────────────────────────────────────────────────────────────

  /// The main content widget to display within the background and app bar wrapper.
  final Widget child;

  // ─── AppBar ────────────────────────────────────────────────────────────────

  /// The title text displayed in the app bar.
  final String title;

  /// Optional custom widget to replace the default title text.
  final Widget? titleWidget;

  /// Whether to show a back button in the app bar.
  final bool showBackButton;

  /// Callback triggered when the back button is pressed.
  final VoidCallback? onBackPressed;

  /// Optional leading widget displayed before the title in the app bar.
  final Widget? leading;

  // ─── Preset Action Items ───────────────────────────────────────────────────

  /// Whether to show a notification icon in the app bar.
  final bool showNotification;

  /// Callback triggered when the notification icon is pressed.
  final VoidCallback? onNotificationPressed;

  /// Optional badge count displayed on the notification icon.
  final int? notificationBadgeCount;

  /// Whether to show a search icon in the app bar.
  final bool showSearch;

  /// Callback triggered when the search icon is pressed.
  final VoidCallback? onSearchPressed;

  /// Whether to show a call icon in the app bar.
  final bool showCall;

  /// Callback triggered when the call icon is pressed.
  final VoidCallback? onCallPressed;

  /// Whether to show an options menu icon in the app bar.
  final bool showOptions;

  /// Menu items for the options popup menu.
  final List<PopupMenuEntry<dynamic>>? optionMenuItems;

  /// Callback triggered when an option menu item is selected.
  final void Function(dynamic value)? onOptionSelected;

  // ─── Extra Custom Actions ──────────────────────────────────────────────────

  /// Additional custom action widgets to display in the app bar.
  final List<Widget>? actions;

  // ─── Layout & Styling ──────────────────────────────────────────────────────

  /// Optional bottom navigation bar widget.
  final Widget? bottomNavigationBar;

  /// Optional floating action button widget.
  final Widget? floatingActionButton;

  /// Background color of the app bar.
  final Color? appBarColor;

  /// Height of the app bar. Defaults to [AppConfig.defaultAppBarHeight].
  final double? appBarHeight;

  // ─── Refresh ───────────────────────────────────────────────────────────────

  /// Whether to enable pull-to-refresh functionality.
  final bool isRefresh;

  /// Callback triggered when the user pulls to refresh.
  final Future<void> Function()? onRefresh;

  // ─── Loading ───────────────────────────────────────────────────────────────

  /// Whether to show the loading indicator overlay.
  final bool isLoading;

  /// Custom widget to display during loading state. Defaults to [AppConfig.loadingWidget].
  final Widget? loadingWidget;

  // ─── Error ─────────────────────────────────────────────────────────────────

  /// Whether to show the error state overlay.
  final bool isError;

  /// Error message to display in the error state.
  final String? errorMessage;

  /// Callback triggered when the user taps the retry button in error state.
  final VoidCallback? onRetry;

  // ─── Misc ──────────────────────────────────────────────────────────────────

  /// Whether to apply safe area padding.
  final bool useSafeArea;

  /// Whether the child widget should be scrollable.
  final bool isChildScrollable;

  /// Background color of the status bar.
  final Color? statusBarColor;

  /// Brightness of the status bar icons.
  final Brightness? statusBarBrightness;

  /// The child widget to display as the main content.

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
      body: Stack(
        children: [
          // ── Background layer ─────────────────────────────────────────
          // Renders either an image (AppBackground.image), a solid
          // color (AppBackground.color), or the default AppConfig.backgroundColor.
          Positioned.fill(
            child: _backgroundType == _BackgroundType.image
                ? Image(
                    image: backgroundImage!,
                    fit: BoxFit.cover,
                  )
                : _backgroundType == _BackgroundType.color
                    ? ColoredBox(color: backgroundColor!)
                    : ColoredBox(color: AppConfig.backgroundColor),
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

  /// Builds the app bar section.
  ///
  /// - Back button is hidden by default ([showBackButton] = false).
  /// - Title is only rendered when [title] is non-empty (or [titleWidget] is provided).
  /// - Preset icons (notification, search, call, options) are shown based on their flags.
  /// - Extra [actions] are appended after preset icons.
  Widget _buildAppBar(BuildContext context) {
    // Determine whether to show any leading widget
    final bool hasLeading = showBackButton || leading != null;

    // Title widget: prefer titleWidget, then fall back to title string (only if non-empty)
    final Widget? resolvedTitle = titleWidget ??
        (title.isNotEmpty
            ? Text(title, style: AppStyles.titleTextStyle)
            : null);

    return Container(
      color: appBarColor ?? Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // ── Leading / Back Button ──────────────────────────────────────
          if (showBackButton)
            GestureDetector(
              onTap: onBackPressed ?? () => Navigator.of(context).maybePop(),
              child: AppStyles.backIcon,
            )
          else if (leading != null)
            leading!,

          if (hasLeading) const SizedBox(width: 12),

          // ── Title ──────────────────────────────────────────────────────
          if (resolvedTitle != null)
            Expanded(child: resolvedTitle)
          else
            const Spacer(),

          // ── Preset: Search ─────────────────────────────────────────────
          if (showSearch)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: onSearchPressed,
              tooltip: 'Search',
            ),

          // ── Preset: Call ───────────────────────────────────────────────
          if (showCall)
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: onCallPressed,
              tooltip: 'Call',
            ),

          // ── Preset: Notification (with optional badge) ─────────────────
          if (showNotification)
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: onNotificationPressed,
                  tooltip: 'Notifications',
                ),
                if (notificationBadgeCount != null &&
                    notificationBadgeCount! > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: IgnorePointer(
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          notificationBadgeCount! > 99
                              ? '99+'
                              : '$notificationBadgeCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

          // ── Preset: Options (3-dot menu) ───────────────────────────────
          if (showOptions)
            PopupMenuButton<dynamic>(
              icon: const Icon(Icons.more_vert),
              tooltip: 'More options',
              onSelected: onOptionSelected,
              itemBuilder: (context) => optionMenuItems ?? [],
            ),

          // ── Extra Custom Actions ───────────────────────────────────────
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
