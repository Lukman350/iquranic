import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './user_bloc.dart';
import './events/auth_event.dart';
import './states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserBloc _userCubit;

  AuthBloc(this._userCubit) : super(AuthInitial()) {
    on<LoginPressed>(_onLoginPressed);
    on<LoginReset>(_onLoginReset);
    on<LoginWithGooglePressed>(_onLoginWithGooglePressed);
    on<LoginWithFacebookPressed>(_onLoginWithFacebookPressed);
    on<AuthLogout>(_onLogout);
  }

  void _onLoginPressed(LoginPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading(type: EAuthType.email));

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: event.credential.email, password: event.credential.password);
      _userCubit.user = userCredential.user;

      emit(AuthSuccess(type: EAuthType.email));
    } on FirebaseAuthException catch (error) {
      emit(AuthError(message: error.message, type: EAuthType.email));
    } catch (error) {
      emit(AuthFatalError(message: error.toString(), type: EAuthType.email));
    }
  }

  void _onLoginWithGooglePressed(LoginWithGooglePressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading(type: EAuthType.google));

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw FirebaseAuthException(code: 'ERROR_GOOGLE_LOGIN_CANCELLED', message: 'Google login cancelled by user');
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      _userCubit.user = userCredential.user;

      emit(AuthSuccess(type: EAuthType.google));
    } on FirebaseAuthException catch (error) {
      emit(AuthError(message: error.message, type: EAuthType.google));
    } catch (error) {
      emit(AuthFatalError(message: error.toString(), type: EAuthType.google));
    }
  }

  void _onLoginWithFacebookPressed(LoginWithFacebookPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading(type: EAuthType.facebook));

    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        throw FirebaseAuthException(code: 'ERROR_FACEBOOK_LOGIN_CANCELLED', message: 'Facebook login failed');
      }

      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken!.token);

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      _userCubit.user = userCredential.user;

      emit(AuthSuccess(type: EAuthType.facebook));
    } on FirebaseAuthException catch (error) {
      emit(AuthError(message: error.message, type: EAuthType.facebook));
    } catch (error) {
      emit(AuthFatalError(message: error.toString(), type: EAuthType.facebook));
    }
  }

  void _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    await _auth.signOut();
    _userCubit.user = null;
    emit(AuthInitial());
  }

  void _onLoginReset(LoginReset event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
