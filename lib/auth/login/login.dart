import 'package:flutter/material.dart';

import '../../home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Connexion',
              style: Theme.of(context).textTheme.displayMedium,
            ),

            const SizedBox(height: 15),

            // Email field
            const TextField(
              decoration: InputDecoration(hintText: 'Email'),
            ),

            // Password field
            const TextField(
              decoration: InputDecoration(hintText: 'Mot de passe'),
            ),

            const SizedBox(height: 15),

            // Submit
            ElevatedButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomePage(),
                  ),
                  (Route<void> route) => false),
              child: const Text('Se connecter'),
            ),

            // Forgotten password
            TextButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité en cours de développement'),
                ),
              ),
              child: const Text('Mot de passe oublié'),
            ),
          ],
        ),
      ),
    );
  }
}
