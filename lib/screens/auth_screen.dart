import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/user_bloc.dart';
import '../themes/app_colors.dart';
import '../widgets/app_snackbar.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw Exception('Google login has been cancelled by the user');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status != LoginStatus.success) {
      throw Exception('Facebook login failed');
    }

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    final UserBloc userBloc = context.read<UserBloc>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/images/mosquee.png',
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                  opacity: const AlwaysStoppedAnimation(0.3),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Login to iQuranic',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'As a registered user, you can save your favorite surahs and track your progress.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: authBloc.state.authFormKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: authBloc.state.emailController,
                        keyboardType: TextInputType.emailAddress,
                        enabled: !authBloc.state.isLoading,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: AppColors.secondaryLight,
                          labelStyle: TextStyle(
                            color: AppColors.primary.withOpacity(0.8),
                            fontSize: 13,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Enter your email address',
                          hintStyle: TextStyle(
                            color: AppColors.primary.withOpacity(0.8),
                            fontSize: 13,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red[700]!,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red[700]!,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: authBloc.state.error,
                          errorStyle: TextStyle(
                            color: Colors.red[700],
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          bool validateEmail(String email) {
                            return RegExp(
                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(email);
                          }

                          if (value!.isEmpty) {
                            return 'Please enter your email address';
                          } else if (!validateEmail(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<AuthBloc, AuthState>(
                        bloc: authBloc,
                        builder: (context, state) {
                          return TextFormField(
                            controller: state.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            enabled: !state.isLoading,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: AppColors.secondaryLight,
                              labelStyle: TextStyle(
                                color: AppColors.primary.withOpacity(0.8),
                                fontSize: 13,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 15,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                color: AppColors.primary.withOpacity(0.8),
                                fontSize: 13,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  authBloc.togglePasswordVisibility();
                                },
                                icon: Icon(
                                  state.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.primary.withOpacity(0.8),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red[700]!,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red[700]!,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorText: state.error,
                              errorStyle: TextStyle(
                                color: Colors.red[700],
                                fontSize: 13,
                              ),
                            ),
                            obscureText: !state.isPasswordVisible,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onFieldSubmitted: (test) {
                              debugPrint(test);
                              if (state.authFormKey.currentState!.validate()) {
                                debugPrint('Sign in');
                                debugPrint(state.emailController.text);
                                debugPrint(state.passwordController.text);
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (authBloc.state.authFormKey.currentState == null) {
                            return;
                          }

                          if (authBloc.state.authFormKey.currentState!
                              .validate()) {
                            await authBloc.signIn(
                              email: authBloc.state.emailController.text,
                              password: authBloc.state.passwordController.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 13,
                          ),
                        ),
                        child: authBloc.state.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.backgroundLight,
                                  ),
                                ),
                              )
                            : const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Or continue with',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          UserCredential userCredential =
                              await signInWithFacebook();

                          debugPrint(userCredential.user.toString());
                        } catch (e) {
                          debugPrint(e.toString());

                          Future.delayed(
                            Duration.zero,
                            () => AppSnackBar.show(
                              context: context,
                              message: e.toString(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.facebook,
                        color: AppColors.primary,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () async {
                        try {
                          UserCredential userCredential =
                              await signInWithGoogle();

                          debugPrint(userCredential.user.toString());

                          userBloc.user = userCredential.user;

                          await Future.delayed(const Duration(seconds: 1), () {
                            AppSnackBar.show(
                              context: context,
                              message: 'Google login successful',
                              backgroundColor: AppColors.secondaryLight,
                              textColor: AppColors.primary,
                            );

                            Navigator.of(context).pushReplacementNamed('/');
                          });
                        } catch (e) {
                          debugPrint(e.toString());

                          Future.delayed(
                            Duration.zero,
                            () => AppSnackBar.show(
                              context: context,
                              message: e.toString(),
                            ),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(50),
                      radius: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Image.asset(
                          'assets/images/google.png',
                          height: 40,
                          width: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(5),
                      minimumSize: const Size(0, 0),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Register Here',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textLink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
