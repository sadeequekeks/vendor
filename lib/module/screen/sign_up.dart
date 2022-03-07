import 'package:flutter/material.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/shared/widget/button/primary_button.dart';
import 'package:vendors/shared/widget/card/male_female_radio.dart';
import 'package:vendors/shared/widget/form/email_text_field.dart';
import 'package:vendors/shared/widget/form/pass_text_field.dart';
import 'package:vendors/shared/widget/form/text_field.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.clear();
    password.clear();
    fname.clear();
    lname.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 30.0),
                InputTextField(
                  controller: fname,
                  hintText: 'John',
                  labelText: 'First Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15.0),
                InputTextField(
                  controller: lname,
                  hintText: 'Doe',
                  labelText: 'Last Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15.0),
                EmailTextField(
                  controller: email,
                  hintText: 'johndoe@example.com',
                  labelText: 'email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 15.0),
                PassTextField(
                  controller: password,
                  hintText: '*******',
                  labelText: 'Password',
                  icon: Icons.password,
                ),
                const SizedBox(height: 15.0),
                const MaleFemalePicker(),
                const SizedBox(height: 20.0),
                isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      )
                    : PrimaryButton(
                        title: 'Sign up',
                        onTap: (startLoading, stopLoading, btnState) async {
                          setState(() {
                            isLoading = true;
                          });
                          await si.firebaseService
                              .register(
                            email: email.text,
                            password: password.text,
                            fName: fname.text,
                            lName: lname.text,
                          )
                              .then((value) {
                            print(value);
                          });
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                const SizedBox(height: 17.0),
                const Text(
                  'By continuing you agree to our',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Terms & Conditions',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
