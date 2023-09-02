import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String headingText;
  final List<DropdownMenuItem<String>> items;
  final String hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;

  CustomDropdownFormField({
    required this.headingText,
    required this.items,
    required this.hintText,
    required this.validator,
    required this.onChanged,
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
              child:  DropdownButtonFormField<String>(
                items: items,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  // contentPadding: EdgeInsets.zero,
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xff263238),
                      width: 0.1,
                    ),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  hintText,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                validator: validator,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
