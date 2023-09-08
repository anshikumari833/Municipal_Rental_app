// import 'package:fluttertoast/fluttertoast.dart';

String getCurrentDate() {
  DateTime cDate = DateTime.now();
  int year = cDate.year;
  String month = (cDate.month + 1).toString().padLeft(2, '0');
  String day = cDate.day.toString().padLeft(2, '0');

  String fullDate = '$year-$month-$day';
  return fullDate;
}

String getDateBeforeYears(int years) {
  DateTime currentDate = DateTime.now();
  int yearInMilliseconds = years * 365 * 24 * 60 * 60 * 1000;
  DateTime dateBeforeYears =
  DateTime.fromMillisecondsSinceEpoch(currentDate.millisecondsSinceEpoch - yearInMilliseconds);

  int year = dateBeforeYears.year;
  int month = dateBeforeYears.month;
  int day = dateBeforeYears.day;

  String formattedDate = '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  return formattedDate;
}

String getBeforeDate(int beforeYear, int beforeMonth, int beforeDay) {
  DateTime cDate = DateTime.now();
  int year = cDate.year - beforeYear;
  int month = (cDate.month + 1) - beforeMonth;
  int day = cDate.day - beforeDay;

  String fullBeforeDate = '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  return fullBeforeDate;
}

String getAfterDate(int afterYear, int afterMonth, int afterDay) {
  DateTime cDate = DateTime.now();
  int year = cDate.year + afterYear;
  int month = (cDate.month + 1) + afterMonth;
  int day = cDate.day + afterDay;

  String fullAfterDate = '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  return fullAfterDate;
}

String returnCapitalize(String currentValue) {
  String capitalizeValue = currentValue.toUpperCase();
  return capitalizeValue;
}

String allowFloatInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^\d*\.?\d*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowNumberInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[0-9\b]+$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowNumberCommaInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[0-9\b,]+$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowCharacterInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[a-zA-Z\s]*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowCharacterSpaceCommaInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[a-zA-Z,! ]*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowCharacterNumberInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[a-zA-Z0-9!]*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowMailInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[a-zA-Z0-9@.!]*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowCharacterNumberSpaceInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[a-zA-Z0-9! ]*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowCharacterCommaInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[a-zA-Z0-9! ]*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowCharacterSpecialInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[a-zA-Z0-9! ]*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowNumberCharacterInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[a-zA-Z0-9! ]*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String allowCharacterNumberSpaceCommaInput(String currentValue, String oldValue, int max) {
  if (currentValue.length > max) return oldValue;

  RegExp re = RegExp(r'^[a-zA-Z0-9!, ]*$');
  if (currentValue.isEmpty || re.hasMatch(currentValue)) return currentValue;
  else return oldValue;
}

String handleNullWithEmpty(value) {
  if (value == null || value.isEmpty || value == '') {
    return '';
  } else {
    return value;
  }
}

String nullToNA(value) {
  if (value == null || value.isEmpty || value == '') {
    return 'NA';
  } else if (value == true) {
    return 'Yes';
  } else if (value == false) {
    return 'No';
  } else {
    return value;
  }
}

String nullToZero(value) {
  if (value == null || value.isEmpty || value == '') {
    return '0';
  } else {
    return double.parse(value).toStringAsFixed(2);
  }
}

String indianAmount(value) {
  if (value == null || value.isEmpty || value == '') {
    return '\u20B9' + '0.00';
  } else {
    return '\u20B9' + double.parse(value).toStringAsFixed(2);
  }
}

bool checkSizeValidation(file) {
  String fileType = (file?.name).split('.').last;
  double fileSize = (file?.size) / (1024 * 1024);

  switch (fileType) {
    case 'jpeg':
    case 'jpg':
    case 'png':
      if (fileSize <= 1) {
        return true;
      } else {
        // Fluttertoast.showToast(msg: 'Image must be less than 1Mb');
        return false;
      }
    case 'pdf':
      if (fileSize <= 10) {
        return true;
      } else {
        // Fluttertoast.showToast(msg: 'PDF must be less than 10Mb');
        return false;
      }
    default:
    // Fluttertoast.showToast(msg: 'File type must be "jpg", "jpeg", "png" or "pdf"');
      return false;
  }
}

String indianDate(value) {
  if (value == null || value == "" || value.isEmpty || value is bool) {
    return "NA";
  } else if (value == true) {
    return 'Yes';
  } else if (value == false) {
    return 'No';
  } else {
    DateTime date = DateTime.parse(value);
    String formattedDate;

    bool hasTime = value.contains(':');
    bool isEncoded = value.contains('T');

    if (!isEncoded) {
      List<String> dateTimeParts = value.split(' ');
      List<String> dateParts = dateTimeParts[0].split('-');
      List<String> timeParts = hasTime ? dateTimeParts[1].split(':') : [];

      String day = dateParts[2];
      String month = dateParts[1];
      String year = dateParts[0];

      if (hasTime) {
        String hours = timeParts[0];
        String minutes = timeParts[1];
        String seconds = timeParts.length > 2 ? timeParts[2] : '';

        if (year.length > 2) {
          formattedDate = '$day-$month-$year $hours:$minutes';
          return formattedDate;
        } else {
          formattedDate = '$year-$month-$day $hours:$minutes';
          return formattedDate;
        }
      } else {
        if (year.length > 2) {
          formattedDate = '$day-$month-$year';
          return formattedDate;
        } else {
          formattedDate = '$year-$month-$day';
          return formattedDate;
        }
      }
    } else {
      List<String> dateParts = value.split('T');
      String date = dateParts[0];

      String year = date.substring(0, 4);
      String month = date.substring(5, 7);
      String day = date.substring(8, 10);

      formattedDate = '$day-$month-$year';
      return formattedDate;
    }
  }
}