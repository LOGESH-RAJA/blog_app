part of 'app_user.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLogged extends AppUserState {
  final UsersEntity usersEntity;
  AppUserLogged({required this.usersEntity});
}
