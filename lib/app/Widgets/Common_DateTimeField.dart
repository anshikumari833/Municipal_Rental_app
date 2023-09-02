import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomDateTimeField extends StatelessWidget {
  final TextEditingController? controller;
  final String headingText;
  final InputDecoration decoration;
  final DateFormat format;
  final Future<DateTime?> Function(BuildContext, DateTime?) onShowPicker;
  final String? Function(DateTime?)? validator;

  CustomDateTimeField({
    required this.headingText,
    this.controller,
    required this.decoration,
    required this.format,
    required this.onShowPicker,
    required this.validator,
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
              child: DateTimeField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                  disabledBorder: InputBorder.none,
                  suffixIcon: Icon(Icons.calendar_month_outlined),
                  hintText: 'yyyy-mm-dd',
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),),
                controller: controller,
                // decoration: decoration,
                format: format,
                onShowPicker: onShowPicker,
                validator: validator,
              ),
            ),
          ),
        ],
      ),
    );



  }
}
