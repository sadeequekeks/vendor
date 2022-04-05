import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/shared/widget/button/primary_button.dart';
import 'package:vendors/shared/widget/card/primary_card.dart';
import 'package:vendors/shared/widget/card/secon_card.dart';
import 'package:vendors/shared/widget/form/email_text_field.dart';
import 'package:vendors/shared/widget/form/num_text_field.dart';
import 'package:vendors/shared/widget/form/pass_text_field.dart';
import 'package:vendors/shared/widget/form/text_field.dart';
import 'package:image_picker/image_picker.dart';

class VendorRegister extends StatefulWidget {
  const VendorRegister({Key? key}) : super(key: key);

  @override
  State<VendorRegister> createState() => _VendorRegisterState();
}

class _VendorRegisterState extends State<VendorRegister> {
  String imagePath = '';
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await si.utilityService
                          .getImage(imgSource: ImageSource.gallery)
                          .then((file) {
                        setState(() {
                          imagePath = file!.path;
                          // print(imagePath);
                        });
                      });
                    },
                    child: CircleAvatar(
                      child:
                          imagePath != '' ? null : const Icon(Icons.camera_alt),
                      radius: 70,
                      backgroundImage:
                          imagePath == '' ? null : FileImage(File(imagePath)),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  const PrimaryCard(
                    child: Text(
                      'Register Your Vendor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  const SecCard(
                    child: InputTextField(
                      hintText: 'Enter Vendor Name',
                      labelText: 'Vendor name',
                      icon: Icons.business_center,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const SecCard(
                    child: EmailTextField(
                      hintText: 'Enter email',
                      labelText: 'Email',
                      icon: Icons.business_center,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const SecCard(
                    child: PassTextField(
                      hintText: 'Enter Password',
                      labelText: 'Create Vendor password',
                      icon: Icons.password,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const SecCard(
                    child: InputTextField(
                      hintText: 'Enter Address',
                      labelText: 'Vendor Address',
                      icon: Icons.business_center,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const SecCard(
                    child: NumTextField(
                      hintText: 'Enter Phone Number',
                      labelText: 'Phone Number',
                      icon: Icons.phone,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  PrimaryButton(
                    title: 'Sign up',
                    onTap: (startLoading, stopLoading, btnState) {},
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
