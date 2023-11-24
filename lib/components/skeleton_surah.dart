import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonSurah extends StatelessWidget {
  const SkeletonSurah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, int index) {
        return Column(
          children: <Widget>[
            const Card(
                child: Padding(
              padding: EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        width: 40, height: 40, shape: BoxShape.circle),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            width: 30, height: 30, shape: BoxShape.circle),
                      ),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            width: 30, height: 30, shape: BoxShape.circle),
                      ),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            width: 30, height: 30, shape: BoxShape.circle),
                      ),
                    ],
                  )
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SkeletonParagraph(
                          style: const SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              height: 10,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SkeletonParagraph(
                          style: const SkeletonParagraphStyle(
                            lines: 2,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              height: 10,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
