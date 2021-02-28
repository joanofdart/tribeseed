import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  HeroDialogRoute({
    @required this.builder,
    RouteSettings settings,
    bool fullScreenDialog = false,
  }) : super(
          settings: settings,
          fullscreenDialog: fullScreenDialog,
        );

  @override
  Color get barrierColor => Colors.blueGrey.withAlpha(100);

  @override
  String get barrierLabel => 'Hero dialog open';

  @override
  bool get barrierDismissible => true;

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }
}
