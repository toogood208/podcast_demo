import 'package:flutter/material.dart';
import 'package:podcast_demo/utils/color_utils.dart';
import 'package:podcast_demo/views/podcast/podcast_page.dart';
import 'package:podcast_demo/views/shared/custom_app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> widgetOptions = [
    const Center(
      child: Text(
        "Coming soon",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
    const PodcastPage(),
    const Center(
      child: Text(
        "Coming soon",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(backgroundColor: backgroundColor),
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff1d1b1b),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xffa5a5a5),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.ads_click),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dataset),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library_rounded),
            label: 'Library',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

