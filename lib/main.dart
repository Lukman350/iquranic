import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:iquranic/app_view.dart';
import 'package:iquranic/bloc/auth_bloc.dart';
import 'package:iquranic/bloc/theme_bloc.dart';
import 'package:iquranic/bloc/user_bloc.dart';
import 'firebase/options/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(
            FirebaseAuth.instance.currentUser,
          ),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            FirebaseAuth.instance,
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}
