import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../routes/app_pages.dart';



class CommonUtils {
  static void showSnackBar(String title, String message, Color backgroundColor){
    Get.snackbar(title,message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white
    );
  }
  static Future<bool> hasLocationPermission() async{
    var status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    } else {
      Map<Permission, PermissionStatus> permStatus = await [
        Permission.location,
      ].request();
      if (await Permission.location.isPermanentlyDenied) {
        openAppSettings();
      } else {
        return true;
      }
    }
    return false;
  }

  static Future<String?> getCurrentLongitude({bool isLatitude=true}) async{
    String retValue = '';
    try {
      if (hasLocationPermission() == false) {
        CommonUtils.showSnackBar(
            'Please Grant Permission', 'Permission Required', Colors.red);
        return '';
      }
      Position _currentPosition;
      await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true)
          .then((Position position) {
        if(isLatitude) {
          retValue = (position.latitude.toString() + '00000000000000000000').substring(0,10);
        } else {
          retValue = (position.longitude.toString() + '00000000000000000000').substring(0,10);
        }
      }).catchError((e) {
        return retValue;
      });
      return retValue;
    } catch (ex) {
      return retValue;
    }
  }

  //=======================1============================

  // static Future<String?> getCurrentLocation() async{
  //   var deviceLocation = null;
  //   try {
  //     if (hasLocationPermission() == false) {
  //       CommonUtils.showSnackBar(
  //           'Please Grant Permission', 'Permission Required', Colors.red);
  //       return '';
  //     }
  //     Position _currentPosition;
  //     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
  //         .then((Position position) {
  //       deviceLocation = position;
  //     }).catchError((e) {
  //       return deviceLocation;
  //     });
  //     return deviceLocation;
  //   } catch (ex) {
  //     return deviceLocation;
  //   }
  // }

  static Future<Position?> getCurrentLocation() async {
    Position? deviceLocation;
    try {
      if (hasLocationPermission() == false) {
        CommonUtils.showSnackBar(
            'Please Grant Permission', 'Permission Required', Colors.red);
        return null;
      }
      Position _currentPosition;
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true)
          .then((Position position) {
        deviceLocation = position;
      }).catchError((e) {
        return null;
      });
      return deviceLocation;
    } catch (ex) {
      return null;
    }
  }


  static Future<String> getToken() async{
    var mStr="";

    mStr = await GetStorage().read('key');
    //   try {
    //     // GetStorage().remove('key');
    //     mStr=await GetStorage().read('key');
    //   } on Exception catch (exception) {
    //     print("dfg");
    // }
    return mStr;
  }

  // static Future<bool> isTc() async{
  //   bool tcRole = false;
  //   try {
  //     tcRole=await GetStorage().read('isTc');
  //   } on Exception catch (exception) {
  //
  //   }
  //   return tcRole;
  // }
  //
  // static Future<bool> isUtc() async{
  //   bool utcRole = false;
  //   try {
  //     utcRole=await GetStorage().read('isUtc');
  //   } on Exception catch (exception) {
  //
  //   }
  //   return utcRole;
  // }
  static Future<bool> setPrinter(String printerName) async{
    await GetStorage().write('printer',printerName);
    return true;
  }

  static Future<String> getPrinter() async{
    return await GetStorage().read('printer');
  }

  static Future<bool> setPrinterConnected() async{
    await GetStorage().write('printer_connected',true);
    return true;
  }

  static Future<bool> getPrinterConnected() async{
    return await GetStorage().read('printer_connected');
  }




  static Future<bool> isLoggedIn() async{
    try{
      if( GetStorage().read('key').toString().trim().length > 0){
        return true;
      } else {
        return false;
      }
    } catch(ex) {
      return false;
    }
  }

  // RouteSettings? redirect(String? route) {
  //   if (GetStorage().read('key') != '' && GetStorage().read('key') != null && (GetStorage().read('isTc') == true || GetStorage().read('isUtc') == true)) {
  //     // User is logged in, redirect to home page
  //     return RouteSettings(name: Routes.HOME);
  //   }
  //   // User is not logged in, allow access to the requested route
  //   return null;
  // }


  static handleResponse(dynamic response) {
    if(response != null){
      if (response.runtimeType == String) {
        try {
          return json.decode(response);
        } catch (e) {
          // Handle parsing error if needed
          print('Error parsing response: $e');
        }
      } else {
        // If the response is already a List, return it as is
        return response;
      }
    }
    else {
      print("No data Found !!!");
    }
    return [];
  }

}