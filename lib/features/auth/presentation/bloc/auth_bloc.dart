import 'dart:async';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/users.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  AuthBloc({
    required CurrentUser currentUser,
    required UserLogin userLogin,
    required UserSignup userSingup,
  })  : _userSignup = userSingup,
        _userLogin = userLogin,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignup>(_onAuthSignup);
    on<AuthLogin>(_onAuthLogin);
    on<AuthUserLogged>(_onAuthUserLogged);
  }

  FutureOr<void> _onAuthSignup(
      AuthSignup event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final respone = await _userSignup(UserSingupParams(
        email: event.email, name: event.name, password: event.password));
    respone.fold(
      (l) {
        emit(AuthFailure(messagee: l.message));
      },
      (r) {
        emit(AuthSucess(user: r));
      },
    );
  }

  FutureOr<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    response.fold(
      (l) {
        emit(AuthFailure(messagee: l.message));
      },
      (r) {
        emit(AuthSucess(user: r));
      },
    );
  }

  FutureOr<void> _onAuthUserLogged(
      AuthUserLogged event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _currentUser.call(NoParams());
    result.fold(
      (l) {
        AuthFailure(messagee: l.message);
        emit(AuthUpdateAppWideUserLogOut());
      },
      (r) {
        AuthSucess(user: r);
        emit(AuthUpdateAppWideUserLoggedIn(usersEntity: r));
      },
    );
  }
}
