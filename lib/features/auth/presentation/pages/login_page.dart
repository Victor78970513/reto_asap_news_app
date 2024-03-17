import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/core/common/widgets/loader.dart';
import 'package:reto_asap/core/theme/app_theme.dart';
import 'package:reto_asap/core/utils/show_snackbar.dart';
import 'package:reto_asap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reto_asap/features/auth/presentation/pages/sign_up_page.dart';
import 'package:reto_asap/features/auth/presentation/widgets/auth_button.dart';
import 'package:reto_asap/features/auth/presentation/widgets/auth_field.dart';
import 'package:reto_asap/service_locator.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = serviceLocator<AuthBloc>();
    super.initState();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    formKey.currentState?.validate();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
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
                  "SIGN IN",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
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
                    buttonText: "Sign In",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthLoginEvent(
                            email: emailCtrl.text.trim(),
                            password: passCtrl.text.trim()));
                      }
                    }),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, SignUpPage.route());
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                        TextSpan(
                            text: "  Sign Up",
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
