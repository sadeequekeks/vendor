class UserModel {
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String location;
  final String userType;

  UserModel(
      {required this.fName,
      required this.lName,
      required this.email,
      required this.location,
      required this.phone,
      required this.userType});
}
