import 'package:flutter/material.dart';

class LeadingMenu extends StatelessWidget {
  const LeadingMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          });
    });
  }
}
