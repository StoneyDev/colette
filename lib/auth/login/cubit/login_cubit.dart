import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void submit(String userId) {
    emit(LoginLoading());

    try {
      emit(
        LoginSuccess(
          User(id: userId),
        ),
      );
    } catch (_) {
      emit(LoginError());
    }
  }
}
