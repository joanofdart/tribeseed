import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(builder: (context, watch, child) {
              final user = watch(currentUserProvider).state;
              return Column(
                children: [
                  Text(user.displayName),
                  Text(user.authStatus),
                  RaisedButton(
                    onPressed: () {},
                    child: const Text('Logout'),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
