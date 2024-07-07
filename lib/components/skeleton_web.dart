import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      children: List.generate(
        kIsWeb ? 28 : 6,
        (index) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                            width: 100,
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            height: 10,
                            width: 200,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
