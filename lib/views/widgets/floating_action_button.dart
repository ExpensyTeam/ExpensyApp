import 'package:flutter/material.dart';
import 'package:expensy/views/themes/colors.dart'; // Adjust this import based on where DarkMode is located.

class FloatingActionButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingActionButtonWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: SizedBox(
        width: 70.0,
        height: 70.0,
        child: Container(
          decoration: BoxDecoration(
            // gradient: DarkMode.buttonGradient,
            color: DarkMode.buttonColor,
            shape: BoxShape.circle,
          ),
          child: FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: Colors.transparent,
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            shape: const CircleBorder(),
          ),
        ),
      ),
    );
  }
}
