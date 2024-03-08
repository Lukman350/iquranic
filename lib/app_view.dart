import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iquranic/bloc/theme_bloc.dart';
import 'package:iquranic/bloc/user_bloc.dart';
import 'package:iquranic/routes/app_routes.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBloc userCubit = context.read<UserBloc>();

    return BlocBuilder<ThemeBloc, ThemeData>(builder: (_, theme) {
      return MaterialApp(
        title: 'iQuranic',
        theme: theme,
        onGenerateInitialRoutes: (initialRoute) => AppRoutes()
            .generateInitialRoutes(initialRoute, userCubit.isSignedIn),
        onGenerateRoute: AppRoutes().generateRoute,
      );
    });
  }
}
