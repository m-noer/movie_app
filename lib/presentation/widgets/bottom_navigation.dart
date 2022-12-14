import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    this.onTap,
  });

  final ValueNotifier<int> selectedIndex;
  final void Function(int value)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.home),
          activeIcon: Icon(IconlyBold.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.activity),
          activeIcon: Icon(IconlyBold.activity),
          label: 'TV Show',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.setting),
          activeIcon: Icon(IconlyBold.setting),
          label: 'Setting',
        ),
      ],
      currentIndex: selectedIndex.value,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
    );
  }
}
