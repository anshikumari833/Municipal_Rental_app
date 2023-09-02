
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String headingText;
  final String Function(String?) validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  CustomTextField({
    required this.headingText,
    required this.hintText,
    required this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                headingText,
                style: GoogleFonts.publicSans(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                  disabledBorder: InputBorder.none,
                  hintText: hintText,
                  hintStyle: GoogleFonts.publicSans(
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                keyboardType: keyboardType,
                validator: validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final String headingText;
//   final String Function(String?) validator;
//
//   CustomTextField({
//     required this.headingText,
//     required this.hintText,
//     required this.validator,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 100,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               child: Text(
//                 headingText,
//                 style: GoogleFonts.publicSans(
//                   fontSize: 14,
//                   fontStyle: FontStyle.normal,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: 260,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   disabledBorder: InputBorder.none,
//                   hintText: hintText,
//                   hintStyle: GoogleFonts.publicSans(
//                     fontSize: 12,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 validator: validator,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

