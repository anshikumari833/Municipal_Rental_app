import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../common/function.dart';
import '../../Home_Screen/views/home_screen_view.dart';
import '../providers/login_screen_provider.dart';

class LoginScreenController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  RxBool incorrectPasswordError = RxBool(false);
  RxBool invalidEmailError = RxBool(false);
  RxBool isPasswordVisible = RxBool(false);
  var isLoading = false.obs;


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<bool> login() async{
    try{
      isLoading.value = true;
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      invalidEmailError.value = email.isEmpty || !GetUtils.isEmail(email);
      incorrectPasswordError.value = password.isEmpty || password.length < 6;

      if (invalidEmailError.value || incorrectPasswordError.value) {
        isLoading.value = false;
        return false;
      }
      if (emailController.value.text.length == 0) {
        print('Invalid Email');
        invalidEmailError.value = true;
        return false;
      }
      if (!GetUtils.isEmail(emailController.value.text)) {
        print('Invalid Email !!!');
        invalidEmailError.value = true;
        return false;
      }
      if (passwordController.value.text.length < 6) {
        print('Invalid Password');
        incorrectPasswordError.value = true;
        return false;
      }
      // await Future.delayed(Duration(seconds: 5));
      var result =  await LoginScreenProvider().userLogin(
          {
            'email': emailController.value.text,
            'password': passwordController.value.text,
            'type': 'mobile',
          });
      if(result.error == true){
        print('Unsuccessful! PLEASE TRY AGAIN');
        CommonUtils.showSnackBar('Could not Login', result.errorMessage, Colors.red);
        isLoading.value = false;
        return false;
      } else {
        if (result.data == null) {
          GetStorage().remove('key');
          isLoading.value = false;
          return false;
        }
        // Get.offAll(()=>HomeView());
        GetStorage().write('key', result.data[0]);
        GetStorage().write('isTc', result.data[1]);
        GetStorage().write('isUtc', result.data[2]);
        GetStorage().write('userName', result.data[3]);
        GetStorage().write('isJe', result.data[4]);
        GetStorage().write('isTd', result.data[5]);

        // Get.offAll(()=>HomeView());
        if(result.data[1] == true || result.data[2] == true || result.data[4] == true || result.data[5] == true){
          // Get.toNamed(Routes.HOME);
          print('Successfully logged in');
          Get.snackbar(
            'Success',
            'Logged in successfully',
            backgroundColor: Colors.red.shade100,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.done,
              color: Colors.green,
            ),
          );
          isLoading.value = false;
           Get.offAll(()=>HomeScreenView());
          return true;
        }
        else {
          print("You don't have permission to login !!!");
          isLoading.value = false;
          return false;
        }
      }
    } catch (error) {
      String errorMessage = '';
      if (error is SocketException) {
        errorMessage = 'Server error. Could not login.';
      } else {
        errorMessage = 'An error occurred. Could not login.';
      }
      print(errorMessage);
      // CommonUtils.showSnackBar('Could not Login', errorMessage, Colors.red);
      isLoading.value = false;
      return false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
