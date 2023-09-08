
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:municipal_rental_tc_app/app/Widgets/Common_TextField.dart';
import '../../../Widgets/Common_DateTimeField.dart';
import '../../../Widgets/Common_Dropdown.dart';
import '../../../Widgets/Common_TextArea.dart';
import '../../../Widgets/location_widget.dart';
import '../controllers/add_shops_controller.dart';

class AddShopsView extends GetView<AddShopsController> {
  const AddShopsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        elevation: 0,
        title:  Text('Add Shop',style: GoogleFonts.publicSans(
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Form(
          key: controller.ShopFormkey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              //CIRLCLE
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.info_circle_fill , size: 18,color: Colors.black),
                    Text("  Select Circle to get Market list ",
                      style: GoogleFonts.publicSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
              ),
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

//ALLOTTEE
              CustomTextField(
                controller: controller.allotteeController,
                headingText: "Allottee", hintText: "Enter allottee",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },),
//CONTACT NO
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
                      "Contact No",
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
                      controller: controller.contactNoController,
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
                        hintText:  "Enter contact no",
                        hintStyle: GoogleFonts.publicSans(
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter contact no';
                        }
                        if (value.length < 10) {
                          return 'Please enter a valid contact no';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
              CustomTextField(
                controller: controller.addressController,
                headingText: "Address", hintText: "Enter Address",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },),
//RATE
              CustomTextField(
                controller: controller.rateController,
                headingText: "Rate", hintText: "Enter rate",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
//LAST PAYMENT DATE
              CustomDateTimeField(
                headingText: 'Select Date',
                controller: controller.lastPaymentDateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                format: DateFormat("yyyy-MM-dd"),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a date and time';
                  }
                  // Add more validation if needed
                  return null;
                },
              ),


//LAST PAYMENT AMOUNT
              CustomTextField(
                controller: controller.lastPaymentAmountController,
                headingText: "Last Payment Amount", hintText: "Enter payment amount",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
//ARREAR
              CustomTextField(
                controller: controller.arrearController,
                headingText: "Arrear", hintText: "Enter arrear",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },),
              CustomTextField(
                controller: controller.allottedLengthController,
                headingText: "Allotteed Length", hintText: "Enter length",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
              CustomTextField(
                controller: controller.allottedBreadthController,
                headingText: "Allotteed Breadth", hintText: "Enter breadth",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
              CustomTextField(
                controller: controller.allottedHeightController,
                headingText: "Allotteed Height", hintText: "Enter height",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
              CustomTextField(
                controller: controller.areaController,
                headingText: "Area", hintText: "Enter Area",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
              CustomTextField(
                controller: controller.presentLengthController,
                headingText: "Present Length", hintText: "Enter length",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
              CustomTextField(
                controller: controller.presentBreadthController,
                headingText: "Present Breadth", hintText: "Enter breadth",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
              CustomTextField(
                controller: controller.presentHeightController,
                headingText: "Present Height", hintText: "Enter height",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
              CustomTextField(
                controller: controller.floorsController,
                headingText: "No. of Floors", hintText: "Enter floors",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },
                keyboardType: TextInputType.number,),
              CustomTextField(
                controller: controller.OccupierController,
                headingText: "Present Occupier", hintText: "Enter occupier",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },),
              CustomTextField(
                controller: controller.tradeLicenseController,
                headingText: "Trade License No", hintText: "Enter license no",validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return "";
              },),

              Obx(() => CustomDropdownFormField(
                headingText: 'Construction',
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
                    : controller.ConstructionList.map<DropdownMenuItem<String>>((construct) {
                  return DropdownMenuItem<String>(
                    value: construct['id'].toString(),
                    child: Text(construct['construction_type'].toString()),
                  );
                }).toList(),
                hintText: 'Select an option',
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
                onChanged: (constValue) {
                  controller.construction.value = constValue.toString();
                },
              ),),
              CustomDropdownFormField(
                headingText: 'Electricity',
// value: controller.currentValue,
                items: [
                  DropdownMenuItem(
                    child: Text("No "),
                    value: "0",
                  ),
                  DropdownMenuItem(
                    child: Text("Yes"),
                    value: "1",
                  ),
                ],
                hintText: 'Select an option',
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
                onChanged: (electricityValue) {
                  controller.electricity.value = electricityValue.toString();
                },
              ),
              CustomDropdownFormField(
                headingText: 'Water',
// value: controller.currentValue,
                items: [
                  DropdownMenuItem(
                    child: Text("No "),
                    value: "0",
                  ),
                  DropdownMenuItem(
                    child: Text("Yes"),
                    value: "1",
                  ),
                ],
                hintText: 'Select an option',
                validator: (value) {

                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
                onChanged: (waterValue) {
                  controller.water.value = waterValue.toString();
                },
              ),
              CustomTextArea(
                controller: controller.remarkController,
                headingText: 'Remarks',
                hintText: 'Enter your remarks....',
                validator: (value) {
                  print('Validator called with value: $value');
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return "";
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.info_circle_fill , size: 18,color: Colors.black),
                    Text(" Click the icon to fetch longitude & latitude",
                      style: GoogleFonts.publicSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
                      color: Colors.blueGrey.shade300,
                      child: Text(
                        "Camera",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.getImage1(ImageSource.camera);
                      }),
                  MaterialButton(
                      color: Colors.teal.shade300,
                      child: Text(
                        "Device",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.getImage1(ImageSource.gallery);
                      })
                ],
              ),
              SizedBox(height: 20),
              Obx(() => controller.selectedImage2Path == ''
                  ? Padding(
                padding: const EdgeInsets.only(top: 30.0),
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
                      color: Colors.blueGrey.shade300,
                      child: Text(
                        "Camera",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.getImage2(ImageSource.camera);
                      }),
                  MaterialButton(
                      color: Colors.teal.shade300,
                      child: Text(
                        "Device",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.getImage2(ImageSource.gallery);
                      })
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  controller.ShopApplicationForm();
                  // if (controller.ShopFormkey.currentState!.validate()) {
                  //   controller.ShopApplicationForm();
                  // }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text('  Submit  '),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}







