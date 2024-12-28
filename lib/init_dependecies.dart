import 'package:blog_app/core/common/cubits/cubit/app_user.dart';
import 'package:blog_app/core/secerts/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependcies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      anonKey: AppSecrets.Anon, url: AppSecrets.SupabaseURl);

  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImple(serviceLocator()),
    )
    ..registerFactory(
      () => UserSignup(serviceLocator()),
    )
    ..registerFactory(
      () => UserLogin(serviceLocator()),
    )
    ..registerFactory(
      () => CurrentUser(serviceLocator()),
    )
    ..registerLazySingleton(
      () => AuthBloc(
          currentUser: serviceLocator(),
          userLogin: serviceLocator(),
          userSingup: serviceLocator()),
    )
    ..registerLazySingleton(
      () => AppUserCubit(),
    );
}
