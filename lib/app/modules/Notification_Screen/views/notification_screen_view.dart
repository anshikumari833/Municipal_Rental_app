import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/notification_screen_controller.dart';

class NotificationScreenView extends GetView<NotificationScreenController> {
  const NotificationScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade100,
        elevation: 0,
        title:  Text('Notification',style: GoogleFonts.publicSans(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotificationScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
