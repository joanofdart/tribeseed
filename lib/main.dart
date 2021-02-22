import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/app/auth_state.dart';
import 'package:tribeseed/app/root_navigator.dart';
import 'package:tribeseed/core/mixins/route_names.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    App(),
  );
}

class App extends StatelessWidget with RouteNames {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: AuthState(
            onLoggedIn: (context) => RootNavigator(),
          ),
        ),
      ),
    );
  }
}
