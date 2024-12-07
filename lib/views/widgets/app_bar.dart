// import 'package:expensy/views/themes/colors.dart';
// import 'package:flutter/material.dart';

// class CustomizedAppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   final Size preferredSize;

//   final String title;
//   final bool showImage;
//   final bool showBackButton;
//   final Color backgroundColor;

//   CustomizedAppBar({
//     Key? key,
//     required this.title,
//     this.showImage = true,
//     this.showBackButton = true,
//     this.backgroundColor = Colors.transparent,
//   })  : preferredSize = const Size.fromHeight(kToolbarHeight),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         border: const Border(
//           bottom: BorderSide(
//             color: Colors.grey,
//             width: 0.5,
//           ),
//         ),
//       ),
//       child: AppBar(
//         leading: showBackButton
//             ? IconButton(
//                 padding: EdgeInsets.zero,
//                 icon: Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       shape: BoxShape.circle),
//                   child: const Icon(
//                     Icons.chevron_left,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//               )
//             : null,
//         title: Row(
//           children: [
//             Text(
//               title,
//               style: const TextStyle(color: Colors.white),
//             ),
//             const Spacer(),
//             if (showImage)
//               CircleAvatar(
//                 radius: 20,
//                 backgroundImage:
//                     const AssetImage('lib/assets/images/image-thumbnail.png'),
//                 backgroundColor: DarkMode.buttonColor,
//               ),
//           ],
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//     );
//   }
// }

import 'package:expensy/views/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomizedAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final bool showImage;
  final bool showBackButton;
  final Color backgroundColor;
  final MainAxisAlignment titleAlignment; // New parameter

  CustomizedAppBar({
    Key? key,
    required this.title,
    this.showImage = true,
    this.showBackButton = true,
    this.backgroundColor = Colors.transparent,
    this.titleAlignment = MainAxisAlignment.start, // Default to start
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: AppBar(
        leading: showBackButton
            ? IconButton(
                padding: EdgeInsets.zero,
                icon: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: Row(
          mainAxisAlignment: titleAlignment, // Align title based on parameter
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            if (showImage && titleAlignment == MainAxisAlignment.start) ...[
              const Spacer(),
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    const AssetImage('lib/assets/images/image-thumbnail.png'),
                backgroundColor: DarkMode.buttonColor,
              ),
            ],
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
