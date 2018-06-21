import 'package:android_istar_app/utils/customcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBarUtil {
  static List<NavigationIconView> get getAllNavigationView {
    List<NavigationIconView> _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.playlist_add_check),
        title: 'Tasks',
        color: CustomColors.theme_color,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.view_headline),
        title: 'Roles',
        color: CustomColors.theme_color,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.calendar_today),
        title: 'Events',
        color: CustomColors.theme_color,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.cloud_download),
        title: 'Repository',
        color: CustomColors.theme_color,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.chat_bubble_outline),
        title: 'Chats',
        color: CustomColors.theme_color,
      )
    ];
    return _navigationViews;
  }

  static newBottomBar(_currentIndex, context) {
    return new BottomNavigationBar(
      items: getAllNavigationView
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      fixedColor: CustomColors.theme_color,
      onTap: (int index) {
        if (_currentIndex == index) {
          print("called in same Page");
        } else {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/dashBoard');
              break;
            case 1:
              Navigator.of(context).pushReplacementNamed('/roles');
              break;
            case 2:
              Navigator.of(context).pushReplacementNamed('/dashBoard');
              break;
            default:
          }
        }
      },
    );
  }
}

class NavigationIconView {
  final Widget _icon;

  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
  })  : _icon = icon,
        _color = color,
        _title = title,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: new Text(title),
          backgroundColor: color,
        );
}
