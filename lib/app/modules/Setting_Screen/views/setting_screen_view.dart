import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/setting_screen_controller.dart';

class SettingScreenView extends GetView<SettingScreenController> {
  const SettingScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        elevation: 0,
        title:  Text('Setting',style: GoogleFonts.publicSans(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SettingScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
