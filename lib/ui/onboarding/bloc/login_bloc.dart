import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socio/constant/app_string_constants.dart';
import 'package:socio/data/repo/onboarding/onboarding_repo.dart';
import 'package:socio/data/repo/onboarding/onboarding_repo_impl.dart';
import 'package:socio/model/user/user.dart';
import 'package:socio/util/edit_text_controller.dart';
import 'package:socio/util/service_locator.dart';

import '../../../bloc/session_bloc.dart';
import '../../../util/user_data_helper.dart';
import '../../../util/utils.dart';
import '../../../util/validations.dart';

class LoginBloc{

  late final EditTextController emailTextController;
  late final EditTextController passTextController;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passFocusNode = FocusNode();

  ValueNotifier<bool> buttonEnabledNotifier = ValueNotifier(false);

  void initialize() {
    _initControllers();
  }

  void _initControllers() {
    emailTextController = EditTextController(
      enabled: true,
      required: true,
      onTextChanged: (value) {
        validateEmailEditTextController();
        checkForAllFields();
      },
    );

    passTextController = EditTextController(
      enabled: true,
      required: true,
      onTextChanged: (value) {
        validatePasswordEditTextController();
        checkForAllFields();
      },
    );
  }

  bool validateEmailEditTextController() {
    emailTextController.error = Validation()
        .isTextNotEmpty(emailTextController.text,
        error: const ValidationError(errorMessage: "Email Id should not be empty"))
        .isValidEmail(emailTextController.text,
        error: const ValidationError(errorMessage: "Please enter a valid Email ID"))
        .doValidation()
        ?.errorMessage;
    return emailTextController.error == null;
  }

  bool validatePasswordEditTextController() {
    passTextController.error = Validation()
        .isTextNotEmpty(passTextController.text,
        error: const ValidationError(errorMessage: "Please enter password"))
        .isTextLengthGreaterThan(passTextController.text, 7,
            error: const ValidationError(errorMessage: "Password length should be atleast 8"))
        .doValidation()
        ?.errorMessage;
    return passTextController.error == null;
  }

  void checkForAllFields() {
    bool check = true;
    check = emailTextController.error == null && Utils.isValidString(emailTextController.value.text) && check;
    check = passTextController.error == null && Utils.isValidString(passTextController.value.text) && check;
    buttonEnabledNotifier.value = check;
  }

  Future<void> userLogin(
      {required String email,
        required String password,
        required void Function({required bool userRegistered, required String uid}) onSuccess,
        required Function(String?) onFailure,
        required VoidCallback onStart,
        bool? isResendOTP}) async {
    User? userResponse;
    try {
      onStart();
      userResponse = await injector<OnBoardingRepoImpl>().loginUser(email: email, password: password);
      if (userResponse != null) {
        debugPrint("userLogin successful");
        debugPrint("$userResponse");
        if (Utils.isValidString(userResponse.uid)) {
          final queryData = await injector<OnBoardingRepoImpl>().getUser(uid: userResponse.uid);
          if (queryData != null) {
            SessionBloc.setUserId(userResponse.uid);
            if (Utils.isValidString(userResponse.email)) SessionBloc.setEmail(userResponse.email!);
            injector<UserDataHelper>().setUserDetailsFromServer(queryData.data());
            onSuccess(userRegistered: true, uid: userResponse.uid);
          } else {
            onSuccess(userRegistered: false, uid: userResponse.uid);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        await createUser(
          email: email,
          password: password,
          onSuccess: ({required uid}) {
            onSuccess(userRegistered: false, uid: uid);
          },
          onFailure: onFailure,
        );
      } else {
        onFailure(AppStringConstants.strDefaultErrorMessage);
      }
    } catch (e) {
      onFailure(AppStringConstants.strDefaultErrorMessage);
      debugPrint("Error userLogin: $e");
    }
  }

  Future<void> createUser(
      {required String email,
        required String password,
        required Function({required String uid}) onSuccess,
        required Function(String?) onFailure,
        VoidCallback? onStart}) async {
    try {
      final response = await injector<OnBoardingRepoImpl>().createUser(email: email, password: password);
      if (response != null) {
        debugPrint("userLogin successful");
        debugPrint("$response");
        if (Utils.isValidString(response.uid)) {
          // SessionBloc.setUserId(response.uid);
          // if (Utils.isValidString(response.email)) SessionBloc.setEmail(response.email!);
          onSuccess(uid: response.uid);
        }
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Error createUser: $e");
    } catch (e) {
      onFailure(AppStringConstants.strDefaultErrorMessage);
      debugPrint("Error default createUser: $e");
    }
  }

  dispose() {
    // TODO: implement dispose
  }
}
