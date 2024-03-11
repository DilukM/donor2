import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final iconImagePath;
  final String buttonText;
  const MyButton({
    super.key,
    required this.iconImagePath,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          width: 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 40,
                  spreadRadius: 5,
                )
              ]),
          child: Center(
            child: Image.asset(iconImagePath),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          buttonText,
          style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ],
    );
  }
}
