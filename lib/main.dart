import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/core/mixins/route_names.dart';
import 'package:tribeseed/features/auth/auth_manager.dart';
import 'package:tribeseed/features/home/home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget with RouteNames {
  App();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          RouteNames.main: (context) => AuthManager(
                authComplete: (_) {
                  return const HomeWidget();
                },
              ),
          RouteNames.home: (context) => const HomeWidget(),
        },
      ),
    );
  }
}
