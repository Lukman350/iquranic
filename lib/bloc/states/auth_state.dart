import 'package:flutter/material.dart';

enum EAuthType { email, google, facebook }

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {
  final EAuthType type;

  AuthLoading({required this.type});

  static EAuthType authType(AuthLoading loading) => loading.type;
}

final class AuthSuccess extends AuthState {
  final EAuthType type;

  AuthSuccess({required this.type});

  static EAuthType authType(AuthSuccess success) => success.type;
}

final class AuthError extends AuthState {
  final String? message;
  final EAuthType type;

  AuthError({required this.message, required this.type});

  static EAuthType authType(AuthError error) => error.type;
}

final class AuthFatalError extends AuthState {
  final String? message;
  final EAuthType type;

  AuthFatalError({required this.message, required this.type});

  static EAuthType authType(AuthFatalError error) => error.type;
}