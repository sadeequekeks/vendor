import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

class MaleFemalePicker extends StatefulWidget {
  const MaleFemalePicker({Key? key}) : super(key: key);

  @override
  _MaleFemalePickerState createState() => _MaleFemalePickerState();
}

class _MaleFemalePickerState extends State<MaleFemalePicker> {
  bool male = true;
  bool female = false;
  late Gender selectedGender;
  void maleGenderSelector() {
    setState(() {
      male = true;
      female = false;
      selectedGender = Gender.male;
    });
  }

  void femaleGenderSelector() {
    setState(() {
      male = false;
      female = true;
      selectedGender = Gender.female;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedGender = Gender.male;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GenderButton(
            selected: male,
            genderName: 'Male',
            genderIcon: CarbonIcons.gender_male,
            gender: selectedGender,
            onTap: maleGenderSelector,
          ),
          const SizedBox(width: 13),
          GenderButton(
            selected: female,
            genderName: 'Female',
            genderIcon: CarbonIcons.gender_female,
            gender: selectedGender,
            onTap: femaleGenderSelector,
          ),
        ],
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final Gender gender;
  final VoidCallback onTap;
  final String genderName;
  final IconData genderIcon;
  final bool selected;
  GenderButton(
      {required this.gender,
      required this.onTap,
      required this.genderName,
      this.selected = false,
      required this.genderIcon});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          // width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (selected) ? Colors.blueAccent : Colors.white,
            border: Border.all(
                width: 0.5,
                color: (selected) ? Colors.white : Colors.blueAccent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                genderName,
                style: TextStyle(
                  color: (selected) ? Colors.white : Colors.blueAccent,
                ),
              ),
              Icon(
                genderIcon,
                color: (selected) ? Colors.white : Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
