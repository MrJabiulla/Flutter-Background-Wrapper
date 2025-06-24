import 'package:flutter/material.dart';
import 'package:flutter_background_wraper/flutter_background_wrapper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppBackgroundExample(),
    );
  }
}

class AppBackgroundExample extends StatefulWidget {
  const AppBackgroundExample({Key? key}) : super(key: key);

  @override
  State<AppBackgroundExample> createState() => _AppBackgroundExampleState();
}

class _AppBackgroundExampleState extends State<AppBackgroundExample> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      title: 'FBW Example',
      backgroundColor: Colors.blue.shade100,
      appBarHeight: 50.0,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => showSearchBar(context),
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No new notifications')),
            );
          },
        ),
      ],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (idx) => setState(() => _currentIndex = idx),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      // Each tab content
      child: _buildTabContent(_currentIndex),
    );
  }

  Widget _buildTabContent(int index) {
    if (index == 0) {
      // Home: Scrollable data
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(16),
        itemCount: 30,
        itemBuilder: (context, i) => Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(child: Text('${i + 1}')),
            title: Text('Item ${i + 1}'),
            subtitle: Text('Details for item ${i + 1}'),
          ),
        ),
      );
    } else if (index == 1) {
      // Search tab
      return const Center(child: Text('Search Content'));
    } else {
      // Profile tab
      return const Center(child: Text('Profile Content'));
    }
  }

  void showSearchBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search'),
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(hintText: 'Type to search...'),
            autofocus: true,
            onSubmitted: (query) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Searching for "$query"...')),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Searching for "${_searchController.text}"...')),
                );
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }
}