import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/common/entities/users.dart';
import 'package:fpdart/fpdart.dart';


abstract class AuthRepository {
  Future<Either<Failure, UsersEntity>> signup(
      {required String name, required String email, required String password});
  Future<Either<Failure, UsersEntity>> login(
      {required String email, required String password});
  Future<Either<Failure, UsersEntity>> currenUser();
}
