import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../../model/user/user.dart';
import '../../../util/edit_text_controller.dart';
import '../../../util/service_locator.dart';
import '../../../util/user_data_helper.dart';
import '../../../util/utils.dart';
import '../../../util/validations.dart';

class UserOnBoardingBloc {

  late EditTextController firstNameController;
  late EditTextController lastNameController;
  late EditTextController emailEditTextController;

  ValueNotifier<String?> genderNotifier = ValueNotifier(null);
  ValueNotifier<String?> genderErrorNotifier = ValueNotifier(null);
  List<String> genderList = ["MALE", "FEMALE", "OTHERS"];

  late EditTextController bioEditTextController;

  late final bool isRegistration;
  late final String emailId;
  late final String uid;

  late UserDataHelper userDataHelper;
  late UserAccount? userAccount;

  ValueNotifier<bool> editProfileValidator = ValueNotifier(false);
  ValueNotifier<bool> submitBtnValidator = ValueNotifier(false);

  final ValueNotifier<Exception?> errorNotifier = ValueNotifier(null);
  final ValueNotifier<bool> isInitialOperationsComplete = ValueNotifier(false);

  XFile? imageFile;
  String? currentProfileUrl = "";

  void initialize({required bool isRegistration, required String emailId, required String uid}) {
    this.isRegistration = isRegistration;
    this.emailId = emailId;
    this.uid = uid;
    userDataHelper = injector<UserDataHelper>();
    userAccount = userDataHelper.userAccountNotifier?.value;
    ///@Todo: Add if for isRegistration is false or true
    if (!isRegistration) {
      genderNotifier.value = userAccount?.gender;
    }
    _initController();
  }

  void _initController() {
    firstNameController = EditTextController(
      enabled: isRegistration,
      required: true,
      text: !isRegistration ? userAccount?.firstName : null,
      onTextChanged: (value) {
        validateFirstNameEditTextController();
        checkForAllFields();
      },
    );

    lastNameController = EditTextController(
      enabled: isRegistration,
      required: true,
      text: !isRegistration ? userAccount?.lastName : null,
      onTextChanged: (value) {
        validateLastNameEditTextController();
        checkForAllFields();
      },
    );

    emailEditTextController = EditTextController(
      enabled: false,
      required: isRegistration,
      text: emailId,
      onTextChanged: (value) {},
    );

    bioEditTextController = EditTextController(
      enabled: true,
      required: true,
      text: !isRegistration ? "${userAccount?.bio}" : null,
      onTextChanged: (value) {
        checkForAllFields();
      },
    );

  }

  bool validateFirstNameEditTextController() {
    firstNameController.error = Validation()
        .isTextNotEmpty(firstNameController.text,
        error: const ValidationError(errorMessage: "Please enter first name"))
        .isTextOnlySpace(firstNameController.text,
        error: const ValidationError(errorMessage: "Please enter Valid name"))
        .doValidation()
        ?.errorMessage;
    return firstNameController.error == null;
  }

  bool validateLastNameEditTextController() {
    lastNameController.error = Validation()
        .isTextNotEmpty(lastNameController.text,
        error: const ValidationError(errorMessage: "Please enter last  name"))
        .isTextOnlySpace(lastNameController.text,
        error: const ValidationError(errorMessage: "Please enter Valid name"))
        .doValidation()
        ?.errorMessage;
    return lastNameController.error == null;
  }

  bool validateEmailEditTextController() {
    emailEditTextController.error = Validation()
    // .isTextNotEmpty(emailEditTextController.text,
    // error: const ValidationError(errorMessage: "Please enter email"))
        .isValidEmail(emailEditTextController.text,
        error: const ValidationError(errorMessage: "Please enter a valid Email ID"))
        .doValidation()
        ?.errorMessage;
    return emailEditTextController.error == null;
  }

  bool validateGenderField() {
    checkForAllFields();
    if (genderNotifier.value == null) {
      genderErrorNotifier.value = 'Please Select a gender';
      return false;
    } else {
      genderErrorNotifier.value = "";
      return true;
    }
  }

  bool validateEntireForm() {
    bool check = true;
    check = validateFirstNameEditTextController() && check;
    check = validateLastNameEditTextController() && check;
    check = validateEmailEditTextController() && check;
    check = validateGenderField() && check;
    return check;
  }

  void checkForAllFields() {
    bool check = true;
    check = firstNameController.error == null && Utils.isValidString(firstNameController.value.text) && check;
    check = lastNameController.error == null && Utils.isValidString(lastNameController.value.text) && check;
    check = emailEditTextController.error == null && Utils.isValidString(emailEditTextController.value.text) && check;
    check = genderNotifier.value != null && check;
    submitBtnValidator.value = check;
  }

  void resetPinFields() {
    firstNameController.error = null;
    firstNameController.text = "";
    lastNameController.error = null;
    lastNameController.text = "";
    emailEditTextController.error = null;
    emailEditTextController.text = "";
    bioEditTextController.error = null;
    bioEditTextController.text = "";
  }

  Future<void> addUpdatePersonalDetails(
      {required VoidCallback onSuccess,
        required Function(String?) onFailure,
        required VoidCallback onStart}) async {
    try {
      onStart();
      final data = UserAccount(
        uid: uid,
        email: emailEditTextController.text,
        bio: bioEditTextController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        profileURL: currentProfileUrl,
        gender: genderNotifier.value,
      );
      final response = await FirebaseFirestore.instance.collection('users').get();
      if (response.docs.isNotEmpty) {
        for (var e in response.docs) {
          if (e.id == uid) {
            await FirebaseFirestore.instance.collection('users').doc(uid).update(data.toJson());
            onSuccess();
            return;
          }
        }
      }
      final docRef = await FirebaseFirestore.instance.collection('users').doc(uid);
      await FirebaseFirestore.instance.runTransaction((transaction) async => transaction.set(docRef, data.toJson())).then((value) {
        injector<UserDataHelper>().setUserDetailsFromServer(data.toJson());
        onSuccess();
      }, onError: (err) {
        onFailure("Something went wrong");
      });
      // await FirebaseFirestore.instance.collection('users').doc(uid).set(data.toJson());
      return;
    } catch (e) {
      onFailure("Something went wrong");
      debugPrint("Error addUpdatePersonalDetails: $e");
    }
  }

  Future<void> uploadProfilePicture({required XFile file}) async {
    if (imageFile == null) return;
    final fileName = basename(imageFile!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(File(imageFile!.path));
    } catch (e) {
      debugPrint('error uploadProfilePicture');
    }
  }

  String getIconForGender(String gender) {
    if (gender == 'MALE') {
      return "assets/images/ic_male.png";
    } else if (gender == 'FEMALE') {
      return "assets/images/ic_female.png";
    } else {
      return "assets/images/ic_other.png";
    }
  }

}