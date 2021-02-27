import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedBackgroundAvatar extends HookWidget {
  final double size;
  final bool animate;
  final EdgeInsets padding;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Duration duration;
  final CircleAvatar avatar;

  const AnimatedBackgroundAvatar({
    Key key,
    this.size = 50,
    this.animate = false,
    this.padding = const EdgeInsets.all(5),
    this.primaryColor = Colors.indigo,
    this.secondaryColor = Colors.pink,
    this.backgroundColor = Colors.red,
    this.duration = const Duration(milliseconds: 600),
    @required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _animationController = useAnimationController(duration: duration);
    final _colorAnimation = useAnimation(
      ColorTween(
        begin: primaryColor,
        end: secondaryColor,
      ).animate(_animationController),
    );

    useEffect(() {
      _animationController.forward();
      void statusListener(status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      }

      _animationController.addStatusListener(statusListener);

      return () => _animationController.removeStatusListener(statusListener);
    }, [_animationController]);

    return SizedBox(
      width: size,
      height: size,
      child: FittedBox(
        child: AnimatedContainer(
          duration: duration,
          padding: padding,
          decoration: BoxDecoration(
            color: animate ? _colorAnimation : backgroundColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: avatar,
        ),
      ),
    );
  }
}
