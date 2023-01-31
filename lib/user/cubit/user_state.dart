part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class AuthentificatedUser extends UserState {
  AuthentificatedUser({required this.user});

  final User user;
}

class UserError extends UserState {}
