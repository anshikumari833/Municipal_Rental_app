import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextArea extends StatelessWidget {
  final String hintText;
  final String headingText;
  final String Function(String?) validator;
  final TextEditingController? controller;

  CustomTextArea({
    required this.headingText,
    required this.hintText,
    required this.validator,
    this.controller,
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
              child:   Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: GoogleFonts.publicSans(
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  maxLines: null, // This allows the text area to expand vertically.
                  validator: validator,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
