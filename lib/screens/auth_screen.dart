import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/params/auth_params.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/events/auth_event.dart';
import '../bloc/states/auth_state.dart';
import '../themes/app_colors.dart';
import '../widgets/app_snackbar.dart';

class AuthScreen extends StatefulWidget {

  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final authFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                child: Hero(
                  tag: 'iquranic-logo',
                  child: Image.asset(
                    'assets/images/logo-transparent.png',
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.bottomCenter,
                    opacity: const AlwaysStoppedAnimation(0.3),
                    colorBlendMode: BlendMode.dstATop,
                  ),
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
                  'As a registered user, you can save your favorite surah\'s and track your progress.',
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
                  key: authFormKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
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
                          errorStyle: TextStyle(
                            color: Colors.red[700],
                            fontSize: 13,
                          ),
                        ),
                        validator: (value) {
                          bool validateEmail(String email) {
                            return RegExp(
                                    r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$')
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
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
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
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible
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
                          errorStyle: TextStyle(
                            color: Colors.red[700],
                            fontSize: 13,
                          ),
                        ),
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess && AuthSuccess.authType(state) == EAuthType.email) {
                            AppSnackBar.show(
                              context: context,
                              message: 'Login successful',
                              backgroundColor: AppColors.secondaryLight,
                              textColor: AppColors.primary,
                            );

                            Future.delayed(Duration.zero, () {
                              if (context.mounted) {
                                Navigator.of(context).pushReplacementNamed('/');
                              }
                            });
                          } else if (state is AuthError && AuthError.authType(state) == EAuthType.email) {
                            AppSnackBar.show(
                              context: context,
                              message: state.message ?? "Something went wrong!",
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthFatalError && AuthFatalError.authType(state) == EAuthType.email) {
                              SchedulerBinding.instance.addPostFrameCallback((_) {
                                showDialog(context: context, builder: (context) {
                                  debugPrint("Fatal Error: ${state.message}");
                                  return AlertDialog(
                                    backgroundColor: Colors.red[100],
                                    icon: const Icon(Icons.error),
                                    iconColor: Colors.red,
                                    title: const Text('Fatal Error'),
                                    content:
                                    Text(state.message ?? "An error occurred"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          context
                                              .read<AuthBloc>()
                                              .add(LoginReset());
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                });
                              });
                          }

                          return ElevatedButton(
                            onPressed: () {
                              if (authFormKey.currentState == null) {
                                return;
                              }

                              if (authFormKey.currentState!.validate()) {
                                final credential = AuthParams(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                                context.read<AuthBloc>().add(
                                  LoginPressed(credential: credential)
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
                            child: state is AuthLoading && AuthLoading.authType(state) == EAuthType.email
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
                          );
                        }
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Or continue with',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if ((state is AuthSuccess && AuthSuccess.authType(state) == EAuthType.google)
                        || (state is AuthSuccess && AuthSuccess.authType(state) == EAuthType.facebook)) {
                      FocusManager.instance.primaryFocus?.unfocus();

                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        AppSnackBar.show(
                          context: context,
                          message: 'Login successful',
                          backgroundColor: AppColors.secondaryLight,
                          textColor: AppColors.primary,
                        );
                        Navigator.of(context).pushReplacementNamed('/');
                      });
                    } else if ((state is AuthError && AuthError.authType(state) == EAuthType.google)
                                || (state is AuthError && AuthError.authType(state) == EAuthType.facebook)) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        AppSnackBar.show(
                          context: context,
                          message: state.message ?? "Something went wrong!",
                        );
                      });
                    }
                  },
                  builder: (context, state) {
                    if ((state is AuthFatalError && AuthFatalError.authType(state) == EAuthType.google)
                        || (state is AuthFatalError && AuthFatalError.authType(state) == EAuthType.facebook)) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.red[100],
                            icon: const Icon(Icons.error),
                            iconColor: Colors.red,
                            title: const Text('Fatal Error'),
                            content:
                            Text(state.message ?? "An error occurred"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context
                                      .read<AuthBloc>()
                                      .add(LoginReset());
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        });
                      });
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        InkWell(
                            onTap: () async {
                              context.read<AuthBloc>().add(
                                  LoginWithGooglePressed()
                              );
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

                             InkWell(
                              onTap: () {
                                context.read<AuthBloc>().add(
                                    LoginWithFacebookPressed()
                                );
                              },
                              borderRadius: BorderRadius.circular(50),
                              radius: 50,
                              child: state is AuthLoading && AuthLoading.authType(state) == EAuthType.facebook
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.backgroundLight,
                                      ),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Icon(
                                        Icons.facebook,
                                        size: 40, color: AppColors.primary,
                                      ),
                                  ),
                        ),
                      ],
                    );
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
