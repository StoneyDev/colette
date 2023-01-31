import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/welcome/welcome.dart';
import 'user/cubit/user_cubit.dart';

class ColetteApp extends StatelessWidget {
  const ColetteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),
        ),
      ],
      child: const MaterialApp(
        home: WelcomePage(),
      ),
    );
  }
}
