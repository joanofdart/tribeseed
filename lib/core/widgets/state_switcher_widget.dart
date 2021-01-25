import 'package:flutter/material.dart';

class StateSwitcherWidget extends StatelessWidget {
  final WidgetBuilder builder;

  const StateSwitcherWidget({
    Key key,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Builder(
        builder: builder,
      ),
    );
  }
}
