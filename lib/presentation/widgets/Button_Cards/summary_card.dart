import 'package:flutter/material.dart';


// class SummaryCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final Color iconColor;
//   final Color bgColor;
//   final Color textColor;


//   const SummaryCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.iconColor,
//     required this.bgColor,
//     required this.textColor,
//   });


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 120,
//       height: 154,
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: iconColor, size: 20),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: textColor,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             subtitle,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 14,
//               color: textColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }








class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color bgColor;
  final Color textColor;


  const SummaryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.bgColor,
    required this.textColor,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      // Remove fixed width here
      // width: 120,
      height: 154,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}



