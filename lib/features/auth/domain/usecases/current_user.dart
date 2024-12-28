

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/users.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

class CurrentUser implements Usecase<UsersEntity, NoParams> {
  final AuthRepository authRepository;

  const CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, UsersEntity>> call(NoParams useSignupParams) async {
    return await authRepository.currenUser();
  }
}
