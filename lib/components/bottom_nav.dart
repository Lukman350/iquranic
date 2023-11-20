import 'package:flutter/material.dart';
import 'package:iquranic/screens/favorite_screen.dart';
import 'package:iquranic/screens/main_screen.dart';
import 'package:iquranic/screens/search_screen.dart';

class BottomNavWidget extends StatefulWidget {
  final int currentIndex;
  const BottomNavWidget({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<BottomNavWidget> createState() => _BottonNavWidgetState();
}

class _BottonNavWidgetState extends State<BottomNavWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      currentIndex: widget.currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          activeIcon: Icon(Icons.home_filled),
          tooltip: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          activeIcon: Icon(Icons.search_rounded),
          tooltip: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
          activeIcon: Icon(Icons.favorite_rounded),
          tooltip: 'Favorite',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MainScreen();
            }));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SearchScreen();
            }));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const FavoriteScreen();
            }));
            break;
        }
      },
    );
  }
}
