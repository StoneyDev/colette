import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void setUser({required User user}) {
    emit(AuthentificatedUser(user: user));
  }
}
