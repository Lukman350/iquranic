import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonCardWeb extends StatelessWidget {
  final int gridCount;
  final double gridAspectRatio;

  const SkeletonCardWeb(
      {Key? key, required this.gridCount, required this.gridAspectRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: gridAspectRatio,
        crossAxisCount: gridCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(kIsWeb ? 28 : 6, (index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        width: 40, height: 40, shape: BoxShape.circle),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SkeletonParagraph(
                          style: const SkeletonParagraphStyle(
                            lines: 1,
                            lineStyle: SkeletonLineStyle(
                              height: 10,
                              width: 150,
                            ),
                          ),
                        ),
                        SkeletonParagraph(
                          style: const SkeletonParagraphStyle(
                            lines: 1,
                            lineStyle: SkeletonLineStyle(
                              height: 10,
                              width: 100,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Center(
                        child: SkeletonParagraph(
                      style: const SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          height: 15,
                          width: 100,
                        ),
                      ),
                    )))
              ],
            ),
          ));
        }));
  }
}
