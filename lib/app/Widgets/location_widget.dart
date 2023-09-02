import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/function.dart';

class LocationInputField extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final bool isLatitude;

  LocationInputField({
    Key? key,
    required this.title,
    required this.controller,
    required this.isLatitude,
  }) : super(key: key);

  @override
  State<LocationInputField> createState() => _LocationInputFieldState();
}

class _LocationInputFieldState extends State<LocationInputField> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: TextFormField(
                    readOnly: true,
                    autofocus: false,
                    cursorColor: Colors.grey,
                    controller: widget.controller,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    // validator: _validateInput,
                  ),
                ),
              ),
              if (isLoading) CircularProgressIndicator(),
              SizedBox(width: 8.0),
              IconButton(
                icon: Icon(
                  Icons.pin_drop_sharp,
                  color: Colors.black ,
                ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  var x = await CommonUtils.getCurrentLongitude(isLatitude: widget.isLatitude);
                  setState(() {
                    isLoading = false;
                    widget.controller!.text = x!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}



String? _validateInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required.';
  }

  // Parse the input value to a double and check if it's within the valid range.
  double latitude;
  try {
    latitude = double.parse(value);
    if (latitude < -90 || latitude > 90) {
      return 'Invalid latitude value. Please enter a value between -90 and 90.';
    }
  } catch (e) {
    return 'Invalid input format. Please enter a valid latitude value.';
  }

  return null; // Return null if the input is valid.
}


//
// class LocationInputField extends StatefulWidget {
//   final String title;
//   final TextEditingController? controller;
//   final bool isLatitude;
//
//   LocationInputField({Key? key,
//     required this.title,
//     required this.controller,
//     required this.isLatitude,
//   }) : super(key: key);
//
//   @override
//   State<LocationInputField> createState() => _LocationInputFieldState();
// }
//
// class _LocationInputFieldState extends State<LocationInputField> {
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.title,
//             style: titleStyle,
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 10),
//             margin: EdgeInsets.only(top: 8.0),
//             height: 52,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12)
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     readOnly: true,
//                     autofocus: false,
//                     cursorColor: Colors.grey,
//                     controller: widget.controller,
//                     style: subTitleStyle,
//                     keyboardType: TextInputType.text,
//                   ),
//                 ),
//                 if (isLoading) CircularProgressIndicator(),
//                 Container(
//                   child: IconButton(
//                     icon: Icon(Icons.pin_drop_sharp,),
//                     onPressed: () async {
//                       setState(() {
//                         isLoading = true;
//                       });
//                       var x = await CommonUtils.getCurrentLongitude(isLatitude: widget.isLatitude);
//                       setState(() {
//                         isLoading = false;
//                         widget.controller!.text = x!;
//                       });
//                     },
//                   ),
//
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }