import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorMessage;
  final FlutterError flutterError;

  const ErrorStateWidget({
    Key key,
    this.errorMessage,
    this.flutterError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ErrorWidget.withDetails(
        error: flutterError,
        message: errorMessage,
      ),
    );
  }
}
