import 'package:flutter/material.dart';

class Earth3D extends StatelessWidget {
  const Earth3D({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox.expand(
        child: Image.asset(
          'assets/images/kupi.jpeg',
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
