import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/app/auth_state.dart';
import 'package:tribeseed/app/app.dart';

import 'services/navigation/navigation_service_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: InitApp(),
    ),
  );
}

class InitApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _navigationService = useProvider(navigationServiceProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      navigatorKey: _navigationService.root,
      home: SafeArea(
        child: AuthState(
          onLoggedIn: (context) => App(),
        ),
      ),
    );
  }
}
