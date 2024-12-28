import 'package:blog_app/core/error/expections.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/core/common/entities/users.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImple extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImple(this.authRemoteDatasource);

  @override
  Future<Either<Failure, UsersEntity>> login(
      {required String email, required String password}) async {
    return _getUsers(
      () => authRemoteDatasource.login(email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, UsersEntity>> signup(
      {required String name,
      required String email,
      required String password}) async {
    return _getUsers(
      () => authRemoteDatasource.signup(
          name: name, email: email, password: password),
    );
  }

  Future<Either<Failure, UsersEntity>> _getUsers(
      Future<UsersEntity> Function() fn) async {
    try {
      final user = await fn();

      return Right(user);
    } on AuthException catch (e) {
      return (Left(Failure(e.message)));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UsersEntity>> currenUser() async {
    try {
      final userData = await authRemoteDatasource.getCurrentUserData();
      if (userData == null) {
        return left(Failure("User not Logged in"));
      }
      return right(userData);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
