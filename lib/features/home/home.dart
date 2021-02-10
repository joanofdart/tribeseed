import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/core/widgets/base_widget.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(builder: (context, watch, child) {
              final currentUser = watch(currentUserProvider).state;

              return Column(
                children: [
                  Text(currentUser?.displayName ?? ''),
                  Text(currentUser?.authStatus ?? ''),
                  RaisedButton(
                    onPressed: () {
                      context.read(authenticationServiceProvider).signOut();
                    },
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
