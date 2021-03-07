import 'dart:ui';

import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final bool showLoading;
  final String buttonText;
  final double textSize;
  final Color buttonColor;
  final Color textColor;
  final Color progressIndicatorColor;
  final VoidCallback onPressed;
  final List<FontFeature> fontFeatures;

  /// TODO: Improve this actionButton to be more reusable.

  const AuthButton({
    Key key,
    this.onPressed,
    this.textSize = 20,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white,
    this.progressIndicatorColor = Colors.white,
    this.showLoading = false,
    @required this.buttonText,
    this.fontFeatures = const [
      FontFeature.enable('smcp'),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      key: key,
      onPressed: showLoading ? null : onPressed,
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: buttonColor,
      child: showLoading
          ? Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(left: 5),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  progressIndicatorColor,
                ),
              ),
            )
          : Text(
              buttonText.toLowerCase(),
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontFeatures: fontFeatures,
              ),
            ),
    );
  }
}
