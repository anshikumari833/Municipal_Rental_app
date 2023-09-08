import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/api_response.dart';
import '../providers/add_shops_provider.dart';

class AddShopsController extends GetxController {
  final GlobalKey<FormState> ShopFormkey = GlobalKey<FormState>();
  // List<Map<String, dynamic>> CircleList = [];
  // List<Map<String, dynamic>> MarketListByCircle = [];
  // List<Map<String, dynamic>> ConstructionList = [];

  RxList<Map<String, dynamic>> CircleList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> MarketListByCircle = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> ConstructionList = <Map<String, dynamic>>[].obs;

  var isPageLoading = false.obs;
  File? _selectedFile1 = null;
  File? _selectedFile2 = null;
  var selectedImage1Path = ''.obs;
  var selectedImage2Path = ''.obs;
  var selectedImage1Size = ''.obs;
  var selectedImage2Size = ''.obs;
  final ImagePicker _picker = ImagePicker();


  var currentValue = "";

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCircleDetail();
    getConstructionDetail();
    allotteeController = TextEditingController();
    contactNoController = TextEditingController();
    addressController = TextEditingController();
    rateController = TextEditingController();
    lastPaymentDateController = TextEditingController();
    lastPaymentAmountController = TextEditingController();
    arrearController = TextEditingController();
    allottedLengthController = TextEditingController();
    allottedBreadthController = TextEditingController();
    allottedHeightController = TextEditingController();
    areaController = TextEditingController();
    presentLengthController = TextEditingController();
    presentBreadthController = TextEditingController();
    presentHeightController = TextEditingController();
    floorsController = TextEditingController();
    OccupierController = TextEditingController();
    tradeLicenseController = TextEditingController();
    longitudeController = TextEditingController();
    latitudeController = TextEditingController();
    remarkController = TextEditingController();

  }

  //CIRCLE LIST (--DROPDOWN LIST--)
Future<void> getCircleDetail() async {
  isPageLoading.value = true;
  APIResponse response = await AddShopsProvider().CircleListData();
  // condition for response error
  if ( response.error == false) {
      var ResponseList = response.data;
      for (var circleDetail in ResponseList) {
        var id = circleDetail['id'].toString();
        var circleName = circleDetail['circle_name'].toString();
        CircleList.add({
          'id': id,
          'circle_name': circleName,
        });
    }
    isPageLoading.value = false;
  } else {
    Get.snackbar(
      '😫😫',
      response.errorMessage,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
    isPageLoading.value = false;
  }
}
  var selectedCircleId;

  //MARKET LIST BY CIRCLE (--DROPDOWN LIST--)
    Future<void> getMarketDetail() async {
    isPageLoading.value = true;
    MarketListByCircle.clear();
    APIResponse response = await AddShopsProvider().MarketListData(selectedCircleId);
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data;
      for (var marketDetail in ResponseList) {
        var id = marketDetail['id'];
        var marketName = marketDetail['market_name'];
        MarketListByCircle.add({
          'id': id,
          'market_name': marketName,
        });
      }
      isPageLoading.value = false;
    } else {
      Get.snackbar(
        '😫😫',
        response.errorMessage,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      isPageLoading.value = false;
    }
}

  //CONSTRUCTION LIST (--DROPDOWN LIST--)
  Future<void> getConstructionDetail() async {
    isPageLoading.value = true;
    APIResponse response = await AddShopsProvider().ConstructionListData();
    // condition for response error
    if ( response.error == false) {
      var ResponseList = response.data;
      for (var constructionDetail in ResponseList) {
        var id = constructionDetail['id'].toString();
        var circleName = constructionDetail['construction_type'].toString();
        ConstructionList.add({
          'id': id,
          'construction_type': circleName,
        });
      }
      isPageLoading.value = false;
    } else {
      Get.snackbar(
        '😫😫',
        response.errorMessage,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      isPageLoading.value = false;
    }
  }



var circle = "".obs;
var market = "".obs;
var construction = "".obs;
var electricity = "".obs;
var water = "".obs;
late TextEditingController allotteeController;
late TextEditingController contactNoController;
late TextEditingController addressController;
late TextEditingController rateController;
late TextEditingController arrearController;
late TextEditingController allottedLengthController;
late TextEditingController allottedBreadthController;
late TextEditingController allottedHeightController;
late TextEditingController areaController;
late TextEditingController presentLengthController;
late TextEditingController presentBreadthController;
late TextEditingController presentHeightController;
late TextEditingController floorsController;
late TextEditingController OccupierController;
late TextEditingController tradeLicenseController;
late TextEditingController longitudeController;
late TextEditingController latitudeController;
late TextEditingController remarkController;
late TextEditingController lastPaymentDateController;
late TextEditingController lastPaymentAmountController;

  //SUBMIT APPLICATION
  Future<void> ShopApplicationForm() async {
    isPageLoading.value = true;
    // // Validate the form fields
    // if (!ShopFormkey.currentState!.validate()) {
    //   // Form has validation errors, do not proceed with submission
    //   return;
    // }
    String _img64Image1, _img64Image2;
    final bytes1 = await _selectedFile1!.readAsBytes();
    final bytes2 = await _selectedFile2!.readAsBytes();
    _img64Image1 = base64Encode(bytes1);
    _img64Image2 = base64Encode(bytes2);
    final bytes01 = base64Decode(_img64Image1);
    final bytes02 = base64Decode(_img64Image2);
    final directory = await getApplicationDocumentsDirectory();
    final file1 = await File('${directory.path}/image1.png').create();
    final file2 = await File('${directory.path}/image2.png').create();
    await file1.writeAsBytes(bytes01);
    await file2.writeAsBytes(bytes02);
    var result = await AddShopsProvider().SubmitShopApplication(
        {
          'circleId': circle.value.toString(),
          'marketId': market.value.toString(),
          'allottee': allotteeController.value.text,
          'contactNo': contactNoController.value.text,
          'address': addressController.value.text,
          'rate': rateController.value.text,
          'arrear': arrearController.value.text,
          'allottedLength': allottedLengthController.value.text,
          'allottedBreadth': allottedBreadthController.value.text,
          'allottedHeight': allottedHeightController.value.text,
          'area': areaController.value.text,
          'presentLength': presentLengthController.value.text,
          'presentBreadth': presentBreadthController.value.text,
          'presentHeight': presentHeightController.value.text,
          'noOfFloors': floorsController.value.text,
          'presentOccupier': OccupierController.value.text,
          'tradeLicense': tradeLicenseController.value.text,
          'construction': construction.value.toString(),
          'electricity': electricity.value.toString(),
          'water': water.value.toString(),
          'lastPaymentDate': lastPaymentDateController.value.text,
          'lastPaymentAmount': lastPaymentAmountController.value.text,
          'longitude': longitudeController.value.text,
          'latitude': latitudeController.value.text,
          'remarks': remarkController.value.text,
          'photo1Path':file1,
          'photo2Path':file2,
    });
    if (result.error == false) {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        title: 'Success',
        desc: 'Your form has been submitted successfully.',
        btnOkOnPress: () {
          Get.back();
        },
      )..show();
      Get.snackbar(
        '😁😁',
        result.errorMessage,
        backgroundColor: Colors.lightBlueAccent,
        colorText: Colors.white,
      );
      isPageLoading.value = false;
    }
    else {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Error',
        desc: result.errorMessage,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
      Get.snackbar(
        '😫😫',
        result.errorMessage,
        backgroundColor: Colors.lightBlueAccent,
        colorText: Colors.white,
      );
      isPageLoading.value = false;
    }
  }

  void getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      maxWidth: 850,
      maxHeight: 850,
      imageQuality: 1,
    );
    if (image != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 900,
        maxHeight: 900,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (cropped != null) {
        _selectedFile1 = File(cropped.path);
        selectedImage1Path.value = cropped.path;
        selectedImage1Size.value =
            (File(selectedImage1Path.value).lengthSync() / 1024 / 1024)
                .toStringAsFixed(2) +
                "Mb";
      }
    }
  }

  void getImage1(ImageSource imageSource) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: imageSource,
    );
    if (pickedFile != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 900,
        maxHeight: 900,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (cropped == null) {
        _selectedFile1 = null;
        selectedImage1Path.value = '';
        selectedImage1Size.value = '';
      } else {
        // Add a check for valid file types
        if (!['.jpg', '.jpeg', '.png']
            .contains(path.extension(cropped.path).toLowerCase())) {
          Get.snackbar(
            'Error',
            'Invalid file format. Please select a valid image.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
          return;
        }

        selectedImage1Path.value = cropped.path;
        _selectedFile1 = File(selectedImage1Path.value);
        selectedImage1Size.value =
            (File(selectedImage1Path.value).lengthSync() / 1024 / 1024)
                .toStringAsFixed(2) +
                "Mb";
      }
    } else {
      Get.snackbar(
        'Error',
        'No image selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
  }

  void getImage2(ImageSource imageSource) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: imageSource,
    );
    if (pickedFile != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 900,
        maxHeight: 900,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (cropped == null) {
        _selectedFile2 = null;
        selectedImage2Path.value = '';
        selectedImage2Size.value = '';
      } else {
        // Add a check for valid file types
        if (!['.jpg', '.jpeg', '.png']
            .contains(path.extension(cropped.path).toLowerCase())) {
          Get.snackbar(
            'Error',
            'Invalid file format. Please select a valid image.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
          return;
        }

        selectedImage2Path.value = cropped.path;
        _selectedFile2 = File(selectedImage2Path.value);
        selectedImage2Size.value =
            (File(selectedImage2Path.value).lengthSync() / 1024 / 1024)
                .toStringAsFixed(2) +
                "Mb";
      }
    } else {
      Get.snackbar(
        'Error',
        'No image selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
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
