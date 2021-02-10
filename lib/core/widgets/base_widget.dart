import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  const BaseWidget({
    Key key,
    this.child,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: child,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
