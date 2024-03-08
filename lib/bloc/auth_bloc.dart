import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isPasswordVisible;

  final authFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthState({
    this.isLoading = false,
    this.error,
    this.isPasswordVisible = false,
  });

  AuthState.loading() : this(isLoading: true);
  AuthState.success() : this();
  AuthState.error(String error) : this(error: error);
  AuthState.togglePasswordVisibility(
    bool value,
  ) : this(isPasswordVisible: value, isLoading: false);
}

class AuthBloc extends Cubit<AuthState> {
  final FirebaseAuth _auth;

  AuthBloc(this._auth) : super(AuthState());

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthState.loading());

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthState.success());
    } on FirebaseAuthException catch (e) {
      emit(AuthState.error(e.message!));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  void togglePasswordVisibility() {
    emit(
      AuthState.togglePasswordVisibility(
        !state.isPasswordVisible,
      ),
    );
  }
}
