import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/services/navigation/navigation_service_providers.dart';

import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';

class HeroPopUpCard extends HookWidget {
  final VoidCallback onTap;
  final String heroTag;
  final Widget child;
  final Widget popupChild;
  final Color transitionContainerColor;

  const HeroPopUpCard({
    Key key,
    this.onTap,
    @required this.heroTag,
    @required this.child,
    @required this.popupChild,
    this.transitionContainerColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigationService = useProvider(navigationServiceProvider);

    return GestureDetector(
      onTap: () {
        _navigationService.rootState.push(
          HeroDialogRoute(
            builder: (context) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(32.0),
                child: Hero(
                  tag: heroTag,
                  child: popupChild,
                ),
              );
            },
          ),
        );
      },
      child: Hero(
        tag: heroTag,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        flightShuttleBuilder: (
          flightContext,
          animation,
          flightDirection,
          fromHeroContext,
          toHeroContext,
        ) {
          return Container(
            width: animation.value,
            height: animation.value,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        child: child,
      ),
    );
  }
}
