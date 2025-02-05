import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: const Color.fromARGB(255, 109, 109, 109),
            width: 0.7,
          ),
        ),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: -25.0,
        color: DarkMode.neutralColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home_filled,
                color: widget.selectedIndex == 0
                    ? DarkMode.buttonColor
                    : Colors.grey,
                size: 30,
              ),
              onPressed: () => widget.onItemTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.domain_verification,
                color: widget.selectedIndex == 1
                    ? DarkMode.buttonColor
                    : Colors.grey,
                size: 30,
              ),
              onPressed: () => widget.onItemTapped(1),
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: widget.selectedIndex == 2
                    ? DarkMode.buttonColor
                    : Colors.grey,
                size: 30,
              ),
              onPressed: () => widget.onItemTapped(2),
            ),
            IconButton(
              icon: Icon(
                Icons.settings_rounded,
                color: widget.selectedIndex == 3
                    ? DarkMode.buttonColor
                    : Colors.grey,
                size: 30,
              ),
              onPressed: () => widget.onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
