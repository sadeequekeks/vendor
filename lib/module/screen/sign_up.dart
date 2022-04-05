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
  TextEditingController locationC = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isLoading = false;
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    controllers.addAll([email, password, fname, lname]);
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
                InputTextField(
                  controller: locationC,
                  hintText: 'Kaduna, Nigeria.',
                  labelText: 'Location',
                  icon: Icons.location_city,
                ),
                const SizedBox(height: 15.0),
                InputTextField(
                  controller: phone,
                  hintText: '+2348045567600',
                  labelText: 'Phone',
                  icon: Icons.phone,
                ),
                const SizedBox(height: 15.0),
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
                          startLoading();
                          await si.authService
                              .register(
                            email: email.text,
                            password: password.text,
                            fName: fname.text,
                            lName: lname.text,
                            location: locationC.text,
                            phone: phone.text,
                          )
                              .then((id) {
                            if (id!.isNotEmpty) {
                              stopLoading();
                              si.dialogService.showToaster(
                                  '${email.text} has been created successfully');
                              si.utilityService.clearFields(controllers);
                            } else {
                              stopLoading();
                              si.dialogService.showToaster(
                                  'An error occured while registering a user');
                            }
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
