import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBloc extends Cubit<User?> {
  final User? user;

  UserBloc(this.user) : super(user);

  bool get isSignedIn => user != null;
  bool get isEmailVerified => user?.emailVerified ?? false;
  String? get uid => user?.uid;
  String? get displayName => user?.displayName;
  String? get email => user?.email;
  String? get photoURL => user?.photoURL;

  set user(User? user) => emit(user);
}
