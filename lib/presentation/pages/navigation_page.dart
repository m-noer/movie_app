import 'package:flutter/material.dart';
import 'package:movie_app/presentation/pages/home_page.dart';
import 'package:movie_app/presentation/widgets/bottom_navigation.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _selectedIndex = ValueNotifier<int>(0);

  final _pages = <Widget>[
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (context, _, __) => IndexedStack(
          index: _selectedIndex.value,
          children: _pages.map((page) => page).toList(),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (context, _, __) => BottomNavigation(
          onTap: (int index) {
            _selectedIndex.value = index;
          },
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}
