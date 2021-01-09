import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;

  const BaseWidget({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: child,
      ),
    );
  }
}
