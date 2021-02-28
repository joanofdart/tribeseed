import 'package:flutter/material.dart';

class ConstrainedView extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const ConstrainedView({
    Key key,
    @required this.child,
    this.width = 250,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < width || constraints.maxHeight < height) {
          return Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
