import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendors/module/screen/admin/admin_dashboard.dart';
import 'package:vendors/shared/model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String imagePath = '';
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          widget.user.userType == 'admin'
              ? si.routerService.nextScreen(
                  context,
                  const AdminDashboard(),
                )
              : si.dialogService.showToaster('Sign Out');
        },
        label: widget.user.userType == 'admin'
            ? const Text(
                'Admin Dashboard',
              )
            : const Text('Sign Out'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  UserInfo(
                    fName: widget.user.fName,
                    lName: widget.user.lName,
                    phone: widget.user.phone,
                    location: widget.user.location,
                    email: widget.user.email,
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

class UserInfo extends StatelessWidget {
  final String fName;
  final String lName;
  final String email;
  final String location;
  final String phone;
  const UserInfo({
    Key? key,
    required this.email,
    required this.fName,
    required this.lName,
    required this.location,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "User Information",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Divider(
                    color: Colors.black38,
                  ),
                  Container(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        leading: const Icon(Icons.person),
                        title: const Text("Name"),
                        subtitle: Text("$fName $lName"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text("Email"),
                        subtitle: Text(email),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text("Phone"),
                        subtitle: Text(phone),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        leading: const Icon(Icons.my_location),
                        title: const Text("Location"),
                        subtitle: Text(location),
                      ),
                      const ListTile(
                        leading: Icon(Icons.person),
                        title: Text("About Me"),
                        subtitle: Text(
                            "This is a about me link and you can khow about me in this section."),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
