import 'package:blog_app/core/common/cubits/cubit/app_user.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/blog/presenstation/pages/blog_page.dart';
import 'package:blog_app/init_dependecies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependcies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<
            AppUserCubit>(), // Assuming you have AppUserCubit registered in your service locator
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    context
        .read<AuthBloc>()
        .add(AuthUserLogged()); // Triggers an event to check user status
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemMode,
      home: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<AppUserCubit, AppUserState>(
            builder: (context, appUserState) {
              if (appUserState is AppUserLogged) {
                return const BlogPage();
              } else {
                return const LoginPage();
              }
            },
          );
        },
        listener: (context, state) {
          // Handle auth state changes
          if (state is AuthUpdateAppWideUserLogOut) {
            context.read<AppUserCubit>().updateUser(null);
          }
          if (state is AuthUpdateAppWideUserLoggedIn) {
            context.read<AppUserCubit>().updateUser(state.usersEntity);
          }
        },
      ),
    );
  }
}
