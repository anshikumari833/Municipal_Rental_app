import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/setting_screen_controller.dart';

class SettingScreenView extends GetView<SettingScreenController> {
  const SettingScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //IMAGE-NAME-BUTTON(EDIT PROFILE)
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child:Column(
                    children: [SizedBox(height: 20),
                      // Container  (
                      //   width: 100,
                      //   height:100,
                      //   child: Image.asset(
                      //     "assets/images/profile.png",
                      //    ),
                      // ),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0, // Border width
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            "assets/images/profile.png",
                          ),
                        ),
                      ),

                      SizedBox(height: 15),
                      Text(
                        'Tax Collector',
                        style: TextStyle(
                          color: Color(0xFF0E100F),
                          fontSize: 14,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                          letterSpacing: -0.28,
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
            //ACCOUNT
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30,vertical: 2),
              child: Row(
                children: [
                  Text('Account',style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7E8491),
                  )),
                ],
              ),
            ),
            //CHANGE Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              child: GestureDetector(
                onTap: () {
                  _showChangePasswordDialog(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFf1f3f3),
                        width: 2.0,
                      ),
                      bottom: BorderSide(
                        color: Color(0xFFf1f3f3),
                        width: 2.0,
                      ),
                    ),
                  ),
                  height: 48.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0E100F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30,vertical: 2),
              child: Row(
                children: [
                  Text('Preferences',style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7E8491),
                  )),
                ],
              ),
            ),
            //THEME
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              child: GestureDetector(
                onTap: () {
                  print('Container tapped! theme');
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFf1f3f3),
                        width: 2.0,
                      ),
                      bottom: BorderSide(
                        color: Color(0xFFf1f3f3),
                        width: 2.0,
                      ),
                    ),
                  ),
                  height: 48.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.invert_colors_on_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0), // Gap between icon and text
                      Text(
                        'Theme',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0E100F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //MORE
            SizedBox(height:50,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30,vertical: 2),
              child: Row(
                children: [
                  Text('More',style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7E8491),
                  )),
                ],
              ),
            ),
            //FAQ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              child: GestureDetector(
                onTap: () {
                  print('Container tapped! FAQ');
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFf1f3f3),
                        width: 2.0,
                      ),
                    ),
                  ),
                  height: 48.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.contact_support_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0), // Gap between icon and text
                      Text(
                        'FAQ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0E100F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //ABOUT US
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
              child: GestureDetector(
                onTap: () {
                  print('Container tapped! About us');
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFf1f3f3),
                        width: 2.0,
                      ),
                    ),
                  ),
                  height: 48.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.0), // Gap between icon and text
                      Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0E100F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //LOGOUT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              child: GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: "AMC",
                    titleStyle: TextStyle(color: Colors.red,fontSize: 20),
                    middleText: "Are you sure you want to log out?",
                    middleTextStyle: TextStyle(color: Colors.black),
                    barrierDismissible: false,
                    backgroundColor: Colors.white,
                    radius: 10.0,
                    confirm: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.indigo.shade300,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onPressed: () {
                          // GetStorage().remove('key');
                          // GetStorage().remove('isTc');
                          // GetStorage().remove('isUtc');
                          // GetStorage().remove('userName');
                          //   Get.reset();
                          // Clear the entire storage
                          GetStorage().erase();
                          Get.offAllNamed(Routes.LOGIN_SCREEN);
                          // Get.toNamed(Routes.LOGIN_SCREEN);
                        },
                        child: Text("Confirm")),
                    cancel: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.red.shade300,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel")),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFf1f3f3),
                        width: 2.0,
                      ),
                    ),
                  ),
                  height: 48.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: Color(0xFFF44725),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFF44725),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height:70,),
          ],
        ),
      ),
    );
  }
}



// Function to show the change password dialog
void _showChangePasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'New Password'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Add your password change logic here
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Change'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

