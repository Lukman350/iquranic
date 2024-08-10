import 'package:flutter/material.dart';
import 'package:iquranic/api/params/auth_params.dart';
import 'package:iquranic/bloc/auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginPressed extends AuthEvent {
  final AuthParams credential;

  LoginPressed({required this.credential});
}

final class LoginWithGooglePressed extends AuthEvent {}

final class LoginWithFacebookPressed extends AuthEvent {}

final class AuthLogout extends AuthEvent {}

final class LoginReset extends AuthEvent {}

final class AuthLoggedIn extends AuthEvent {
  final AuthBloc user;

  AuthLoggedIn({required this.user});
}