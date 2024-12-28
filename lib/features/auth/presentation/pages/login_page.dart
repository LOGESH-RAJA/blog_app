import 'package:blog_app/core/common/loading_indicator.dart';
import 'package:blog_app/core/common/show_snackbar.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/form_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnakbar(context, state.messagee);
              }
              if (state is AuthSucess) {
                print("Login Sucess");
                showSnakbar(context, state.user.name);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const LoadingIndicator();
              }

              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthField(hintText: "Email", textEditingController: email),
                    const SizedBox(
                      height: 10,
                    ),

                    AuthField(
                      hintText: "Password",
                      textEditingController: password,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // AuthField(hintText: "Email")

                    GradientButton(
                      buttonName: "Sign In",
                      onpressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthLogin(
                              email: email.text, password: password.text));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ));
                      },
                      child: RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.titleMedium,
                              text: 'Don\'t have an Account',
                              children: [
                            TextSpan(
                              text: ' Signup',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold),
                            )
                          ])),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
