import 'package:flutter/material.dart';

class SecCard extends StatelessWidget {
  final Widget child;
  const SecCard({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
