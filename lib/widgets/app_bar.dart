import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../bloc/user_bloc.dart';
import '../themes/app_colors.dart';
import 'app_snackbar.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final UserBloc userCubit = context.read<UserBloc>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Image.asset(
                  'assets/images/hamburger_menu.png',
                  width: 24,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'iQuranic',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            SearchBar(
              trailing: Iterable.generate(1).map((e) {
                return InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(50),
                  child: const Icon(
                    Icons.search,
                    size: 18,
                    color: AppColors.primary,
                  ),
                );
              }).toList(),
              constraints: const BoxConstraints(
                maxWidth: 110,
                minHeight: 35,
              ),
              textStyle: WidgetStateProperty.resolveWith(
                (states) => const TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                ),
              ),
              backgroundColor: WidgetStateColor.resolveWith(
                (states) => AppColors.secondaryLight,
              ),
              shape: WidgetStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: AppColors.secondaryLight,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  FirebaseAuth.instance.signOut();

                  AppSnackBar.show(
                    context: context,
                    message: 'Logout berhasil!',
                    backgroundColor: AppColors.secondaryLight,
                    textColor: AppColors.primary,
                  );

                  userCubit.user = null;

                  Navigator.of(context).pushReplacementNamed('/auth');
                },
                child: BlocBuilder<UserBloc, User?>(
                  bloc: userCubit,
                  builder: (context, state) {
                    return Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryLight,
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: NetworkImage(
                            state?.photoURL ?? 'https://via.placeholder.com/35',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
