import 'package:flutter/material.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/module/screen/sign_up.dart';
import 'package:vendors/module/screen/vendor_register.dart';
import 'package:vendors/shared/widget/button/bottom_nav.dart';
import 'package:vendors/shared/widget/form/email_text_field.dart';
import 'package:vendors/shared/widget/form/pass_text_field.dart';
import 'package:vendors/shared/widget/form/text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
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
                  MaterialButton(
                    onPressed: () async {
                      si.routerService.nextScreen(
                        context,
                        const BottomNav(),
                      );
                    },
                    child: isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 30.0),
                  TextButton(
                    onPressed: () {
                      si.routerService.nextScreen(
                        context,
                        Register(),
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
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {
                      si.routerService.nextScreen(
                        context,
                        VendorRegister(),
                      );
                    },
                    child: const Text(
                      'Register as a Vendor',
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
    );
  }
}
