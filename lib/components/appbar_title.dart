import 'package:flutter/material.dart';
import 'package:iquranic/themes/app_colors.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
