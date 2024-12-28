import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/users.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

class UserSignup implements Usecase<UsersEntity, UserSingupParams> {
  final AuthRepository authRepository;

  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, UsersEntity>> call(
      UserSingupParams useSignupParams) async {
    return await authRepository.signup(
        name: useSignupParams.name,
        email: useSignupParams.email,
        password: useSignupParams.password);
  }
}

class UserSingupParams {
  final String email;
  final String name;
  final String password;

  UserSingupParams(
      {required this.email, required this.name, required this.password});
}
