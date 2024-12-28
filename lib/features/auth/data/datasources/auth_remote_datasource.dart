import 'package:blog_app/core/error/expections.dart';
import 'package:blog_app/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Session? get currenUserSession;

  Future<UserModel> signup(
      {required String name, required String email, required String password});
  Future<UserModel> login({required String email, required String password});

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      if (response.user == null) {
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signup(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, data: {'name': name}, email: email);
      if (response.user == null) {
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currenUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currenUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currenUserSession!.user.id);
        return UserModel.fromJson(userData.first)
            .copyWith(email: currenUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
