import 'package:flutter/material.dart';
import 'package:iquranic/components/appbar_title.dart';

class DrawerWeb extends StatelessWidget {
  const DrawerWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const AppBarTitle(title: 'iQuranic'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
            leading: const Icon(Icons.home),
          ),
          ListTile(
            title: const Text('Search'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/search');
            },
            leading: const Icon(Icons.search),
          ),
          ListTile(
            title: const Text('Favorite'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/favorite');
            },
            leading: const Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
