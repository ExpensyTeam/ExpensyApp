import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';

class SpendCircleWidget extends StatelessWidget {
  const SpendCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center, // Center the content within the stack
          children: [
            // Outer border
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color.fromRGBO(57, 67, 76, 0.471), width: 10),
              ),
            ),
            // Inner border
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color.fromRGBO(82, 92, 101, 1), width: 10),
                  color: DarkMode.buttonColor),
            ),
            // Center content
            Center(
              child: Text(
                "\$1600",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 140,
          child: Text(
            "You have Spend total 60% of your budget",
            style: TextStyle(color: Colors.white),
            maxLines: 2, // Set the maximum number of lines
            overflow: TextOverflow.ellipsis, // Optional: Add
          ),
        )
      ],
    );
  }
}
