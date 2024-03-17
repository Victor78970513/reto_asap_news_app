import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/core/common/widgets/loader.dart';
import 'package:reto_asap/core/theme/app_theme.dart';
import 'package:reto_asap/core/utils/show_snackbar.dart';
import 'package:reto_asap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reto_asap/features/auth/presentation/widgets/auth_button.dart';
import 'package:reto_asap/features/auth/presentation/widgets/auth_field.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    formKey.currentState?.validate();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SIGN UP",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(height: 30),
                AuthField(
                  controller: nameCtrl,
                  hintText: "Name",
                ),
                const SizedBox(height: 30),
                AuthField(
                  controller: emailCtrl,
                  hintText: "Email",
                ),
                const SizedBox(height: 30),
                AuthField(
                  controller: passCtrl,
                  hintText: "Password",
                  isObscureText: true,
                ),
                const SizedBox(height: 30),
                AuthButton(
                    buttonText: "Sign Up",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSigunUpEvent(
                            email: emailCtrl.text.trim(),
                            password: passCtrl.text.trim(),
                            name: nameCtrl.text.trim()));
                      }
                    }),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context, LoginPage.route());
                    Navigator.pop(context);
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Already have an account?",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                        TextSpan(
                            text: "  Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPalleteColor.gradient2,
                                  fontWeight: FontWeight.bold,
                                ))
                      ])),
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
