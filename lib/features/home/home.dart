import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/features/features_providers.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, watch, child) => RaisedButton(
                onPressed: () {
                  context.read(authStateChangesProviderMock).state = false;
                },
                child: const Text('Logout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
