import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/users.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

class UserLogin implements Usecase<UsersEntity, UserLoginParams> {
  final AuthRepository authRepository;

  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, UsersEntity>> call(
      UserLoginParams useSignupParams) async {
    return await authRepository.login(
        email: useSignupParams.email, password: useSignupParams.password);
  }
}

class UserLoginParams {
  final String email;

  final String password;

  UserLoginParams({required this.email, required this.password});
}
