import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  final Color color;
  final Color textColor;
  const CategoriesCard({
    Key? key,
    required this.name,
    required this.onTap,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35.0,
        width: 90.0,
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: color,
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              offset: Offset(0, 1.5),
              color: Colors.blue,
            ),
          ],
        ),
        child: Text(
          ' $name',
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
