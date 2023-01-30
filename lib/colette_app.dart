import 'package:flutter/material.dart';

import 'auth/welcome/welcome.dart';

class ColetteApp extends StatelessWidget {
  const ColetteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomePage(),
    );
  }
}
