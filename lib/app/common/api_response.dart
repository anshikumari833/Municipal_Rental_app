import 'dart:convert';

class APIResponse<T> {
  T data;
  bool error;
  String errorMessage;

  APIResponse({
    required this.data,
    this.error = false,
    required this.errorMessage,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    //constant to store response data
    var decodedData = null;

    // checking response error
    if(json['error'] == false){

      //checking response is string or not and decode it
      if (json['data'] is String) {
        decodedData = jsonDecode(json['data']);
      } else {
        decodedData = json['data'];
      }

      //after checking response type
      if(decodedData['status']){
          return APIResponse(
            data: decodedData['data'],
            error: false,
            errorMessage: decodedData['message'],
          );
        } else {
          return APIResponse(
            data: decodedData['data'],
            error: true,
            errorMessage: decodedData['message'],
          );
        }

    } else {
      return APIResponse(
        data:json['data'],
        error: json['error'],
        errorMessage: 'Server Error! Please try again later!!',
      );
    }
  }
}