import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to white
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    //   statusBarColor: Colors.white,
    // ));
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: Text(
      //     '',
      //     style: GoogleFonts.publicSans(
      //       fontWeight: FontWeight.w600,
      //       fontSize: 16,
      //       fontStyle: FontStyle.normal,
      //       color: Colors.red,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     Icon(Icons.settings, color: Colors.black),
      //     SizedBox(width: 15),
      //     Icon(Icons.power_settings_new, color: Colors.black),
      //     SizedBox(width: 20),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:25,),
          Container(
          decoration: BoxDecoration(
            color: Colors.red.shade300,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(150),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child:Image.asset('assets/images/akola_logo.png')
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(150),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                           ' Akola Municipal Corporation',
                          style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2,),
                        Text(
                          'Municipal Rental',
                          style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
            SizedBox(height:25,),

           Container(
           padding: const EdgeInsets.symmetric(horizontal: 30),
           child: Row(children: [
             Text("Apply" ,style: GoogleFonts.publicSans(
             fontWeight: FontWeight.bold,
               fontSize: 18,
               fontStyle: FontStyle.normal,
               color: Colors.black,
             ),),
           ],),
         ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(260))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Add Shop', 'assets/images/addShop_img.png', Colors.green.shade100, Routes.ADD_SHOPS,),
                  itemDashboard('Add Toll', 'assets/images/addToll_img.png', Colors.red.shade100, Routes.ADD_TOLLS,),

                ],
              ),
            ),
            SizedBox(height:25,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(children: [
                Text("Payment" ,style: GoogleFonts.publicSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                ),),
              ],),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(260))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [

                  itemDashboard('Shop Rent', 'assets/images/payShop_img.png', Colors.blue.shade100, Routes.PAY_SHOP_RENT,),
                  itemDashboard('Toll Rent', 'assets/images/paToll_img.png', Colors.purple.shade100, Routes.PAY_TOLL_RENT,),

                ],
              ),
            ),
            SizedBox(height:25,),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(children: [
                    Text("Menu" ,style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),),
                  ],),
                ),
              ],
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical:20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(260)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerItem(
                  'Notification  ',
                  CupertinoIcons.bell_fill,
                  Colors.yellow.shade100,
                  Routes.NOTIFICATION_SCREEN,
                ),
                  ContainerItem(
                    'Setting  ',
                    Icons.settings,
                    Colors.teal.shade100,
                    Routes.SETTING_SCREEN,
                  ),],
              )
            ),

          ]),),
    );
  }
}


itemDashboard(String title, String imagePath, Color background, String routeName) => GestureDetector(
  onTap: () {
    Get.toNamed(routeName);
  },
  child: Container(
    decoration: BoxDecoration(
        color: background,
        // shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 1),
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 2)
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(imagePath,height:40,),
        ),
        const SizedBox(height: 10),
        Text(title, style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)
      ],
    ),
  ),
);
ContainerItem(String title, IconData iconData, Color background, String routeName) => GestureDetector(
  onTap: () {
    Get.toNamed(routeName);
  },
  child: Container(
    height: 50,
    width:150,
    decoration: BoxDecoration(
      color: background,
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.grey,
          spreadRadius: 1,
          blurRadius: 2,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Icon(iconData, color: Colors.black, size: 24),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
        ),
      ],
    ),
  ),
);
