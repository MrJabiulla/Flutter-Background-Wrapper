# flutter_background_wraper

[![Pub Version](https://img.shields.io/pub/v/flutter_background_wraper.svg)](https://pub.dev/packages/flutter_background_wraper)
[![Pub Likes](https://img.shields.io/pub/likes/flutter_background_wraper.svg)](https://pub.dev/packages/flutter_background_wraper)
[![Pub Points](https://img.shields.io/pub/points/flutter_background_wraper.svg)](https://pub.dev/packages/flutter_background_wraper)
[![Pub Popularity](https://img.shields.io/pub/popularity/flutter_background_wraper.svg)](https://pub.dev/packages/flutter_background_wraper)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful Flutter package that streamlines the creation of consistent, professional-looking app screens. It eliminates boilerplate code by combining **app bar**, **background management**, **state handling**, and **navigation elements** into a single, easy-to-use widget.

---

## 📋 Table of Contents

- [Features](#-features)
- [Usage](#-usage)
  - [Basic — Color Background](#basic--color-background)
  - [Image Background](#image-background)
  - [Full Featured Example](#full-featured-example)
- [Requirements](#-requirements)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

- 🎨 **Solid color or image backgrounds**
- 🔧 **Customizable AppBar** — title, back button, height, and actions
- 🧭 **Bottom navigation bar** and **floating action button** support
- 📜 **Scrollable / non-scrollable** content layout
- ⚡ **Loading & error states** with custom widget support
- 🔄 **Pull-to-refresh** functionality
- 📱 **Status bar** customization
- 🛡️ **Safe area** handling built-in

---


## 📖 Usage

### Basic — Color Background

```dart
AppBackground.color(
  color: Colors.white,
  title: 'Home',
  child: ListView(
    children: [
      ListTile(title: Text('Item 1')),
      ListTile(title: Text('Item 2')),
    ],
  ),
)
```

---

### Image Background

```dart
AppBackground.image(
  image: AssetImage('assets/bg.jpg'),
  title: 'Profile',
  child: Center(
    child: Text('Your content here'),
  ),
)
```

---

### Full Featured Example

```dart
AppBackground.color(
  color: Colors.white54,
  title: 'FBW Example',
  appBarHeight: 50.0,
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.notifications),
      onPressed: () {},
    ),
  ],
  bottomNavigationBar: BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
    ],
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  isRefresh: true,
  onRefresh: () async {
    // Handle refresh logic
  },
  isLoading: false,
  isError: false,
  child: MyContentWidget(),
)
```

---

## 📋 Requirements

| | Minimum Version |
|---|---|
| **Flutter** | `>=2.18.0` |
| **Dart** | `>=2.18.0` |

---

## 🤝 Contributing

Contributions are welcome! Here's how to get started:

1. **Fork** the repository
2. **Create** a new branch
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit** your changes
   ```bash
   git commit -m 'Add some amazing feature'
   ```
4. **Push** to the branch
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open** a Pull Request

Please make sure your code follows the existing style and includes relevant tests.

---

## 📝 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

```
MIT License — Copyright (c) 2024 MrJabiulla
```

---

<p align="center">
  Developed by <a href="https://github.com/MrJabiulla"><b>MrJabiulla</b></a>
</p>