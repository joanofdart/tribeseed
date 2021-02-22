import 'dart:ui';

import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final Color progressIndicatorColor;
  final bool showLoading;
  final String buttonText;
  final List<FontFeature> fontFeatures;

  const ActionButton({
    Key key,
    this.onPressed,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white70,
    this.progressIndicatorColor = Colors.white70,
    this.showLoading = false,
    @required this.buttonText,
    this.fontFeatures = const [
      FontFeature.enable('smcp'),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        key: key,
        onPressed: onPressed,
        color: buttonColor,
        child: AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 500,
          ),
          child: showLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: progressIndicatorColor,
                  ),
                )
              : Text(
                  buttonText.toLowerCase(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontFeatures: fontFeatures,
                  ),
                ),
        ),
      ),
    );
  }
}
