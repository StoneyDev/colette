import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Inscription',
              style: Theme.of(context).textTheme.displayMedium,
            ),

            const SizedBox(height: 15),

            // Firstname field
            const TextField(
              decoration: InputDecoration(hintText: 'Prénom'),
            ),

            // Lastname field
            const TextField(
              decoration: InputDecoration(hintText: 'Nom'),
            ),

            // Email field
            const TextField(
              decoration: InputDecoration(hintText: 'Email'),
            ),

            // Password field
            const TextField(
              decoration: InputDecoration(hintText: 'Mot de passe'),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {},
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
