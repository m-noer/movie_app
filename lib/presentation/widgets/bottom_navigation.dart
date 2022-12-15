import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
          icon: Icon(FluentIcons.movies_and_tv_20_regular),
          activeIcon: Icon(FluentIcons.movies_and_tv_20_filled),
          label: 'Movies',
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.tv_20_regular),
          activeIcon: Icon(FluentIcons.tv_20_filled),
          label: 'TV Show',
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.settings_20_regular),
          activeIcon: Icon(FluentIcons.settings_20_filled),
          label: 'Setting',
        ),
      ],
      currentIndex: selectedIndex.value,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
    );
  }
}
