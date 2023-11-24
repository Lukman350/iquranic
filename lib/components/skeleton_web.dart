import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonCardWeb extends StatelessWidget {
  const SkeletonCardWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 3,
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(28, (index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Expanded(
                    flex: 1,
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          width: 40, height: 40, shape: BoxShape.circle),
                    )),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                ),
                Expanded(
                    flex: 1,
                    child: SkeletonParagraph(
                      style: const SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          height: 10,
                          width: double.infinity,
                        ),
                      ),
                    )),
              ],
            ),
          ));
        }));
  }
}
