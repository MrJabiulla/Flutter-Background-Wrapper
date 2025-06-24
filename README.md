# flutter_background_wraper

A customizable Flutter widget that wraps your screen with built-in support for:

- AppBar with title/back button
- Scrollable/non-scrollable content
- Error view with retry
- Loading state
- Pull-to-refresh

## 🚀 Usage

```dart
AppBackground(
  title: 'Home',
  isLoading: false,
  isError: false,
  isRefresh: true,
  onRefresh: () async {},
  child: Text('Hello World'),
);
