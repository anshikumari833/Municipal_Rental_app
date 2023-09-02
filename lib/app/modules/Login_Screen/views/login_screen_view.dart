import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value == true) {
          return Container(
            child:  Center(
              child:  SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            ),
          );
        } else {
          return  SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height:60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/akola_logo.png",height: 220,width: 220,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Text("Login ",style:GoogleFonts.inter(
                          fontSize:30,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),),
                        SizedBox(height:10,),
                        Text("Please Login To Continue",style:GoogleFonts.inter(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),),
                        // SizedBox(height: size.height * 0.03),
                        SizedBox(height: 35,),
                        Obx(() =>Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(12),
                              labelText: "Username",
                              errorText: controller.invalidEmailError.value ? 'Invalid Email' : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              prefixIcon: Icon(Icons.email,size: 20,),
                            ),
                          ),
                        ),),

                        SizedBox(height: size.height * 0.03),
                        Obx(() => Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: controller.passwordController,
                            decoration: InputDecoration(contentPadding: EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: "Password",
                              errorText: controller.incorrectPasswordError.value ? 'Invalid Password' : null,
                              suffixIcon: IconButton(
                                icon: Icon(controller.isPasswordVisible.value ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  controller.isPasswordVisible.toggle();
                                },
                              ),
                              prefixIcon: Icon(Icons.lock,size: 20,),
                            ),
                            obscureText: !controller.isPasswordVisible.value,
                          ),
                        ),),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              controller.login();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: EdgeInsets.symmetric(horizontal: 130),
                            ),
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),),
                  SizedBox(height:120,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "© 2023 : Akola",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
