import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../themes/app_colors.dart';

class SkeletonCardMobile extends StatelessWidget {
  const SkeletonCardMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: AppColors.backgroundDark,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SkeletonParagraph(
                      style: const SkeletonParagraphStyle(
                        lines: 3,
                        spacing: 3,
                        lineStyle: SkeletonLineStyle(
                          height: 5,
                        ),
                      ),
                    ),
                    SkeletonParagraph(
                      style: const SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 3,
                        lineStyle: SkeletonLineStyle(
                          height: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: AppColors.secondaryLight,
                thickness: 2,
              ),
            ],
          );
        },
      ),
    );
  }
}
