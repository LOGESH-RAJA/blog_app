import 'package:blog_app/core/common/loading_indicator.dart';
import 'package:blog_app/core/common/show_snackbar.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/form_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:blog_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnakbar(context, state.messagee);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const LoadingIndicator();
              }

              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up ",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthField(
                      hintText: "Email",
                      textEditingController: email,
                    ),
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
                    AuthField(
                      hintText: "Name",
                      textEditingController: name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GradientButton(
                      buttonName: "Sign Up",
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignup(
                              name: name.text.trim(),
                              email: email.text.trim(),
                              password: password.text.trim()));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.titleMedium,
                            text: 'Already have an Account',
                            children: [
                          TextSpan(
                            text: '  Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold),
                          )
                        ]))
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
