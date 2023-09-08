import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Widgets/Common_Dropdown.dart';
import '../../../Widgets/Common_TextArea.dart';
import '../../../Widgets/Common_TextField.dart';
import '../../../Widgets/location_widget.dart';
import '../controllers/add_tolls_controller.dart';

class AddTollsView extends GetView<AddTollsController> {
  const AddTollsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade100,
        elevation: 0,
        title:  Text('Add Tolls',style: GoogleFonts.publicSans(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
        centerTitle: true,
      ),
      body:
      SingleChildScrollView(
        child: Form(
          key:controller.TollFormkey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.info_circle_fill , size: 18,color: Colors.black),
                    Text("  Select Market to get Shop list ",
                      style: GoogleFonts.publicSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
              ),
              //CIRLCLE
              Obx(() => CustomDropdownFormField(
                headingText: 'Circle',
                items: controller.isPageLoading.value
                    ? [
                  DropdownMenuItem(
                    value: null,
                    child:  Center(child:SpinKitThreeBounce(
                      color: Colors.blue,
                      size: 20.0,
                    ),),
                  ),
                ]
                    : controller.CircleList.map<DropdownMenuItem<String>>((circle) {
                  return DropdownMenuItem<String>(
                    value: circle['id'].toString(),
                    child: Text(circle['circle_name'].toString()),
                  );
                }).toList(),
                hintText: 'Select an option',
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
                onChanged: (circleValue) {
                  controller.circle.value = circleValue.toString();
                  controller.selectedCircleId = circleValue.toString();
                  controller.getMarketDetail();
                },
              ),),
              //MARKET
              Obx(() => CustomDropdownFormField(
                headingText: 'Market',
                items: controller.isPageLoading.value
                    ? [
                  DropdownMenuItem(
                    value: null,
                    child:  Center(child:SpinKitThreeBounce(
                      color: Colors.blue,
                      size: 20.0,
                    ),),
                  ),
                ]
                    : controller.MarketListByCircle.map<DropdownMenuItem<String>>((circle) {
                  return DropdownMenuItem<String>(
                    value: circle['id'].toString(),
                    child: Text(circle['market_name'].toString()),
                  );
                }).toList(),
                hintText: 'Select an option',
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
                onChanged: (marketValue) {
                  controller.market.value = marketValue.toString();
                },
              ),),
              CustomTextField(
                controller: controller.vendorNameController,
                headingText: "Vendor Name",
                hintText: "Enter vendor name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return "";
                },),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          "Mobile No",
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
                        child: TextFormField(
                          controller:  controller.mobileNoController,
                          keyboardType: TextInputType.number,
                          maxLength:10,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                            disabledBorder: InputBorder.none,
                            hintText:  "Enter mobile no",
                            hintStyle: GoogleFonts.publicSans(
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter mobile no';
                            }
                            if (value.length < 10) {
                              return 'Please enter a valid mobile no';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // CustomTextField(
              //   controller: controller.mobileNoController,
              //   headingText: "Mobile No",
              //   hintText: "Enter mobile no",validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'This field is required';
              //   }
              //   return "";
              // },),
              CustomTextField(
                controller: controller.landmarkController,
                headingText: "Landmark",
                hintText: "Enter landmark",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },),
              Obx(() => CustomDropdownFormField(
                headingText: 'Rate',
                items: controller.isPageLoading.value
                    ? [
                  DropdownMenuItem(
                    value: null,
                    child:  Center(child:SpinKitThreeBounce(
                      color: Colors.blue,
                      size: 20.0,
                    ),),
                  ),
                ]
                    : controller.RateList.map<DropdownMenuItem<String>>((circle) {
                  return DropdownMenuItem<String>(
                    value: circle['id'].toString(),
                    child: Text(circle['rate'].toString()),
                  );
                }).toList(),
                hintText: 'Select an option',
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
                onChanged: (rateValue) {
                  controller.rate.value = rateValue.toString();
                },
              ),),
              CustomTextArea(
                controller: controller.remarkController,
                headingText: 'Remarks',
                hintText: 'Enter your remarks....',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return "";
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: LocationInputField(
                  title: 'Longitude',
                  controller: controller.longitudeController,
                  isLatitude: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: LocationInputField(
                  title: 'Latitude',
                  controller: controller.latitudeController,
                  isLatitude: true,
                ),
              ),
              Obx(() => controller.selectedImage1Path == ''
                  ? Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                    child: Text(
                      'Select image from camera/gallery',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    )),
              )
                  : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Image.file(
                            File(controller.selectedImage1Path.value))),
                  ),
                  Obx(() => Center(
                      child: Text(
                        controller.selectedImage1Size.value,
                        style: TextStyle(
                            fontSize: 12, color: Colors.black),
                      )))
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      color: Colors.brown[200],
                      child: Text(
                        "Camera",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.getImage1(ImageSource.camera);
                      }),
                  MaterialButton(
                      color: Colors.orange[300],
                      child: Text(
                        "Device",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.getImage1(ImageSource.gallery);
                      })
                ],
              ),
              Obx(() => controller.selectedImage2Path == ''
                  ? Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                    child: Text(
                      'Select image from camera/gallery',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    )),
              )
                  : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Image.file(
                            File(controller.selectedImage2Path.value))),
                  ),
                  Obx(() => Center(
                      child: Text(
                        controller.selectedImage2Size.value,
                        style: TextStyle(
                            fontSize: 12, color: Colors.black),
                      )))
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      color: Colors.brown[200],
                      child: Text(
                        "Camera",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.getImage2(ImageSource.camera);
                      }),
                  MaterialButton(
                      color: Colors.orange[300],
                      child: Text(
                        "Device",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.getImage2(ImageSource.gallery);
                      })
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.validateForm()) {
                    controller.TollsApplicationForm();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text('Submit'),
              ),

              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
