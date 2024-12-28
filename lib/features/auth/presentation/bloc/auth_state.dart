part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSucess extends AuthState {
  final UsersEntity user;

  AuthSucess({required this.user});
}

final class AuthFailure extends AuthState {
  final String messagee;

  AuthFailure({required this.messagee});
}

final class AuthUpdateAppWideUserLoggedIn extends AuthState {
  final UsersEntity usersEntity;
  AuthUpdateAppWideUserLoggedIn({required this.usersEntity});
}

final class AuthUpdateAppWideUserLogOut extends AuthState {}
