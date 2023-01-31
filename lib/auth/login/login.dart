import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../activity/activity.dart';
import '../../models/user.dart';
import '../../user/cubit/user_cubit.dart';
import 'cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, LoginState state) {
          // The user has successfully logged in
          if (state is LoginSuccess) {
            final UserCubit userCubit = context.read<UserCubit>();

            // Set user data
            userCubit.setUser(user: User(id: state.user.id));

            // Redirect to activity page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const ActivityPage(),
              ),
              (Route<void> route) => false,
            );
          }

          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Une erreur est survenue lors de votre connexion'),
              ),
            );
          }
        },
        builder: (BuildContext context, LoginState state) {
          if (state is LoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

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

                  // Id field
                  TextField(
                    controller: idController,
                    onChanged: (String value) => setState(() {}),
                    decoration: const InputDecoration(hintText: 'Id'),
                  ),

                  // Password field
                  const TextField(
                    decoration: InputDecoration(hintText: 'Mot de passe'),
                  ),

                  const SizedBox(height: 15),

                  // Submit
                  ElevatedButton(
                    onPressed:
                        idController.text.isEmpty ? null : () => context.read<LoginCubit>().submit(idController.text),
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
        },
      ),
    );
  }
}
