import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/core/common/entities/users.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());
  void updateUser(UsersEntity? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLogged(usersEntity: user));
    }
  }
}
