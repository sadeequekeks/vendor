import 'package:flutter/material.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/module/screen/sign_up.dart';
import 'package:vendors/shared/model/user_model.dart';
import 'package:vendors/shared/widget/button/bottom_nav.dart';
import 'package:vendors/shared/widget/button/primary_button.dart';
import 'package:vendors/shared/widget/form/email_text_field.dart';
import 'package:vendors/shared/widget/form/pass_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/chef.png'),
                      height: 150.0,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    EmailTextField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                      hintText: 'johndoa@example.com',
                      labelText: 'Email',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 15.0),
                    PassTextField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      hintText: 'Enter Password',
                      labelText: 'Password',
                      icon: Icons.password,
                    ),
                    const SizedBox(height: 15.0),
                    PrimaryButton(
                      title: 'Sign In',
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          startLoading();
                          await si.authService
                              .loginUser(
                                  email: email.text, password: password.text)
                              .then((user) {
                            if (user.runtimeType == String) {
                              stopLoading();
                              si.dialogService.showToaster(user);
                            } else {
                              startLoading();
                              si.routerService.popReplaceScreen(
                                context,
                                BottomNav(
                                  user: user,
                                ),
                              );
                            }
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 30.0),
                    TextButton(
                      onPressed: () {
                        si.routerService.nextScreen(
                          context,
                          const Register(),
                        );
                      },
                      child: const Text(
                        'Create an account here - Sign up',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
