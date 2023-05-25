import 'package:flutter/material.dart';
import 'package:leo/services/auth.service.dart';
import 'package:leo/utils/helpers/email_validator.dart';
import 'package:leo/utils/helpers/password_validator.dart';
import 'package:leo/utils/routes.dart';
import 'package:leo/widgets/loading.dart';

import '../utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(
      () {
        setState(() {});
      },
    );
    passwordController.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: (val) => validateEmail(val),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: 'Enter you email',
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        controller: passwordController,
                        validator: (val) => validatePassword(val),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        obscureText: isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Enter you password',
                          labelText: 'Password',
                          suffixIcon: passwordController.text.isEmpty
                              ? Container(
                                  width: 0,
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        isPasswordVisible = !isPasswordVisible;
                                      },
                                    );
                                  },
                                  icon: isPasswordVisible
                                      ? const Icon(
                                          Icons.visibility_off,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                        ),
                                ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 3),
                      ElevatedButton(
                        onPressed: () async {
                          final isValid = formKey.currentState?.validate();
                          if (isValid ?? true) {
                            try {
                              setState(
                                () {
                                  isLoading = true;
                                },
                              );
                              final navigator = Navigator.of(context);
                              await AuthService().signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              navigator.pushReplacementNamed(
                                RouteEnums.eventsPage,
                              );
                            } catch (error) {
                              // final String errorMessage =
                              //     getMessageFromErrorCode(error);
                              // _showErrorDialog(
                              //   context,
                              //   errorMessage,
                              // );
                            } finally {
                              setState(
                                () {
                                  isLoading = false;
                                },
                              );
                            }
                          }
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
