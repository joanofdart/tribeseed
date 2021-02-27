import 'dart:ui';

import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final bool showLoading;
  final double width;
  final String assetImagePath;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color progressIndicatorColor;
  final VoidCallback onPressed;
  final List<FontFeature> fontFeatures;
  final String semanticLabel;
  final String buttonText;

  const SocialAuthButton({
    Key key,
    this.showLoading = false,
    this.width = double.infinity,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.blue,
    this.borderColor = Colors.blue,
    this.progressIndicatorColor = Colors.white70,
    this.fontFeatures = const [
      FontFeature.enable('smcp'),
    ],
    this.onPressed,
    @required this.assetImagePath,
    @required this.semanticLabel,
    @required this.buttonText,
  })  : assert(assetImagePath != null),
        assert(semanticLabel != null),
        assert(buttonText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlineButton(
        onPressed: onPressed,
        borderSide: BorderSide(
          color: borderColor,
          width: 0.6,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: backgroundColor,
        splashColor: textColor,
        textColor: textColor,
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
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      assetImagePath,
                      height: 20,
                      semanticLabel: semanticLabel,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      buttonText.toLowerCase(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontFeatures: fontFeatures,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
