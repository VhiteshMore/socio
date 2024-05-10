import 'dart:math';

import 'package:intl/intl.dart';

class Utils {

  static final RegExp regexNumber = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
  static final RegExp regexEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"); // translates to word@word.word

  static bool isValidString(String? value) {
    return value != null && value.isNotEmpty;
  }

  static bool isValidNum(num? value) {
    return value != null && value != 0;
  }

  static bool isValidList(List? value) {
    return value != null && value.isNotEmpty;
  }

  static bool areListsEqual(List? list1, List list2) {
    if(list1 != null){
      // check if both are lists
      if(list1.length!=list2.length) {
        return false;
      }
      // check if elements are equal
      for(int i=0;i<list1.length;i++) {
        if(list1[i]!=list2[i]) {
          return false;
        }
      }
      return true;
    }
    else{
      return false;
    }
  }

  static String? validateMobile(String name, {bool isCode = false}) {
    if (name.isEmpty || !regexNumber.hasMatch(name) || (!name.startsWith('6') && !name.startsWith('7') && !name.startsWith('8') && !name.startsWith('9'))) {
      if(isCode){
        return " ";
      }
      return 'Please enter a valid mobile number';
    }else {
      return null;
    }
  }

  static formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    String second = sec.toString().length <= 1 ? "0$sec":"$sec";
    return "${second}s";
  }

  static String? validateField(String? name,{String? errorMsg}) {
    if (name == null || name.isEmpty) {
      return errorMsg ?? 'Select data';
    } else {
      return null;
    }
  }

  static String? validateFirstName(String name) {
    if (name.isEmpty) {
      return 'Please enter your First Name.';
    }else if(name.contains(" ")){
      return 'Please remove space from First Name.';
    }else{
      return null;
    }
  }

  static String? validateLastName(String lastname) {
    if (lastname.isEmpty) {
      return 'Please enter your Last Name.';
    }else if(lastname.contains(" ")){
      return 'Please remove space from Last Name.';
    }else{
      return null;
    }
  }

  static String? validateDOB(String dob) {
    if (dob.isEmpty) {
      return 'Please enter your Date of Birth.';
    }else{
      return null;
    }
  }

  static String? validateEmailAddress(String email, bool isEmailVerified) {
    if (email.isEmpty) {
      return 'Please enter your Email ID.';
    }else if(!regexEmail.hasMatch(email)){
      return 'Invalid Email ID. Please re-enter the correct Email ID.';
    }else if (!isEmailVerified){
      return 'Please verify your email before proceeding';
    } else {
      return null;
    }
  }

  static String? validateUserName(String username, bool isUserNameAvailable) {
    if (username.isEmpty) {
      return 'Please enter a username';
    } else if(username.contains(' ')) {
      return 'Please remove spaces from username';
    } else if (!isUserNameAvailable) {
      return 'Please check if username $username is available.';
    } else {
      return null;
    }
  }

  static String? validateTextField(String string, bool isEnabled) {
    if (string.isEmpty && isEnabled)  {
      return 'Please enter text...';
    }else{
      return null;
    }
  }

  static String convertDateFormat(String originalDate) {
    DateTime dateTime = DateTime.parse(originalDate);
    String formattedDate = DateFormat('dd MMM yyyy // hh:mm a').format(dateTime);
    return formattedDate;
  }

  static String convertDateFormatFromEpoch(int epochDate) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochDate);
    String formattedDate = DateFormat('dd MMM yyyy , hh:mm a').format(dateTime);
    return formattedDate;
  }

  static String capitalizeFirstLetter(String value) {
    var result = value[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
        cap = false;
      }
    }
    return result;
  }

  static Set<int> listsContainSimilarItems(List<int> list1, List<int> list2) {
    // Convert the lists to sets to efficiently check for similarity.
    Set<int> set1 = Set.from(list1);
    Set<int> set2 = Set.from(list2);

    Set<int> commonPost = set1.intersection(set2);
    // Check if there is an intersection between the two sets.
    return commonPost;
  }

  static Set<int> listsContainDisimilarItems(List<int> list1, List<int> list2) {
    // Convert the lists to sets to efficiently check for similarity.
    Set<int> set1 = Set.from(list1);
    Set<int> set2 = Set.from(list2);

    Set<int> commonPost = set1.difference(set2);
    // Check if there is an intersection between the two sets.
    return commonPost;
  }

}

extension StringUtils on String {

  String initials() {
    String result = "";
    List<String> words = split(" ");
    for (var element in words) {
      if (element.trim().isNotEmpty && result.length < 2) {
        result += element[0].trim();
      }
    }

    return result.trim().toUpperCase();
  }
}

extension ListUtils on List{
  List<T> filterNulls<T>(){
    return List.from(where((e) => (e != null)).toList());
  }
}
