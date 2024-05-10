import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socio/ui/theme/index.dart';
import 'package:socio/ui/widgets/so_error_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constant/app_string_constants.dart';
import '../../util/service_locator.dart';
import '../../util/utils.dart';
import '../../util/widget_utility.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/so_dialogs.dart';
import '../widgets/so_loader.dart';
import 'bloc/user_onboarding_bloc.dart';
import 'login_screen.dart';

class PersonalDetailScreen extends StatefulWidget {
  static const route = "PersonalDetailScreen";

  final bool isRegistration;
  final String emailId;
  final String uid;

  const PersonalDetailScreen(
      {required this.isRegistration,
      required this.emailId,
      required this.uid,
      Key? key})
      : super(key: key);

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  final UserOnBoardingBloc bloc = UserOnBoardingBloc();

  @override
  void initState() {
    bloc.initialize(isRegistration: widget.isRegistration, emailId: widget.emailId, uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: Navigator.of(context).canPop() ? GestureDetector(
              onTap: () {
                if (widget.isRegistration) {
                  SoDialogs.showAlertDialog(
                    title: "Are you sure?",
                    description: "Your data will be lost, if you go back.",
                    primaryButtonTitle: "Okay",
                    onOkayTapWithContext: (BuildContext context) {
                      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route, (route) => false);
                    },
                    secondaryButtonTitle: "Cancel",
                  );
                } else {
                  if (Navigator.of(context).canPop()) {
                    primaryFocus?.unfocus();
                    Navigator.pop(context);
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.arrow_back_ios, size: 20,),
              ),
            ) : null,
            title: !widget.isRegistration ? Text(AppStringConstants.profileScreenTitle, style: TextStyles.editProfileAppBarTitle,) : null,
            actions: !widget.isRegistration ? [
              ValueListenableBuilder(
                valueListenable: bloc.editProfileValidator,
                builder: (context, emailChanged, _) {
                  return GestureDetector(
                      onTap: () {
                        if (bloc.validateEmailEditTextController()) {
                          // profileBloc.updateUserEmail(
                          //   email: bloc.emailEditTextController.text,
                          //   id: bloc.userAccount!.id!,
                          //   onStart: () {
                          //     SoLoader.showLoader();
                          //   },
                          //   onSuccess: () {
                          //     SoLoader.hideLoader();
                          //   },
                          //   onFailure: (errorMessage) {
                          //     SoLoader.hideLoader();
                          //   },
                          // );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Save",
                          style: TextStyles.otpResendActive.copyWith(
                              fontSize: 18,
                              color: !emailChanged ? AppColor().colorGraniteGrey : null),
                        ),
                      )
                  );
                },
              ),
            ] : [],
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isRegistration) Text(
                      AppStringConstants.strHeaderPersonalInfo,
                      style: TextStyles.profileAppBarTitle,
                    ),
                    if (widget.isRegistration) const SizedBox(
                      height: 20.0,
                    ),
                    profilePicture(bloc.imageFile == null
                        ? Utils.isValidString(bloc.currentProfileUrl) ? Image.network(
                            bloc.currentProfileUrl ?? "",
                            height: 100,
                            width: 100,
                          ) : Image.asset('assets/images/avatar.png', height: 100, width: 100,)
                        : Image.file(File(bloc.imageFile!.path))),
                    const SizedBox(height: 10),
                    CustomTextField(
                      enabled: widget.isRegistration,
                      controller: bloc.firstNameController,
                      headerLabel: AppStringConstants.strLabelFirstName,
                      hintText: AppStringConstants.strHintFirstName,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      maxLines: 1,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(50),
                        FilteringTextInputFormatter.allow(RegExp(r'^([a-zA-Z]+ ?){0,3}'))
                      ],
                      onChanged: (val) {},
                    ),
                    CustomTextField(
                      enabled: widget.isRegistration,
                      controller: bloc.lastNameController,
                      headerLabel: AppStringConstants.strLabelLastName,
                      hintText: AppStringConstants.strHintLastName,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      maxLines: 1,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(50),
                        FilteringTextInputFormatter.allow(RegExp(r'^([a-zA-Z]+ ?){0,3}'))
                      ],
                      onChanged: (val) {},
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      enabled: false,
                      controller: bloc.emailEditTextController,
                      headerLabel: AppStringConstants.strLabelEmail,
                      hintText: AppStringConstants.strHintEmail,
                      textInputType: TextInputType.emailAddress,
                      actionKeyboard: TextInputAction.done,
                      maxLines: 1,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      onChanged: (val) {},
                    ),

                    const SizedBox(height: 10),
                    Text(
                      AppStringConstants.strLabelGender,
                      style: TextStyles.textFieldTextStyle,
                    ),
                    const SizedBox(height: 3),
                    ValueListenableBuilder(
                      valueListenable: bloc.genderNotifier,
                      builder: (context, value, _) {
                        return FittedBox(
                          child: Row(
                            children: WidgetUtility.spreadWidgets(WidgetUtility.childrenBuilder((childrn) {
                              childrn.addAll(bloc.genderList.map<Widget>((e) {
                                bool isSelected = e == value;
                                return GestureDetector(
                                  onTap: bloc.isRegistration ? () {
                                    if (value != e) {
                                      bloc.genderNotifier.value = e;
                                      bloc.validateGenderField();
                                    }
                                  } : null,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isSelected ? !bloc.isRegistration ? AppColor().colorHonoluluBlue.withOpacity(0.6) : AppColor().colorHonoluluBlue : AppColor().colorTextFieldFocused,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: WidgetUtility.spreadWidgets([
                                        Image.asset(bloc.getIconForGender(e), height: 24, width: 24, color: isSelected ? AppColor().colorWhite : AppColor().colorBlack),
                                        Text(e, style: TextStyles.privacyPolicyDescription.copyWith(color: isSelected ? Colors.white : null)),
                                      ], interItemSpace: 2),
                                    ),
                                  ),
                                );
                              }));
                            }),interItemSpace: 10),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    ValueListenableBuilder(
                      valueListenable: bloc.genderErrorNotifier,
                      builder: (context, value, _) {
                        if (Utils.isValidString(value)) {
                          return Text(value!, style: TextStyles.errorMessage,);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      enabled: true,
                      controller: bloc.bioEditTextController,
                      headerLabel: AppStringConstants.strLabelBio,
                      hintText: AppStringConstants.strHintBio,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.done,
                      maxLines: 5,
                      maxLength: 150,
                      onChanged: (val) {},
                    ),
                    const SizedBox(height: 20),
                    if (widget.isRegistration)
                      ValueListenableBuilder(
                        valueListenable: bloc.submitBtnValidator,
                        builder: (context, isValid, _) {
                          return GestureDetector(
                            onTap: isValid ? () {
                              if (bloc.validateEntireForm()) {
                                submitButtonClick();
                              }
                            } : null,
                            child: Container(
                              height: 52,
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: isValid ? AppColor().colorHonoluluBlue : AppColor().colorHonoluluBlue.withOpacity(0.7),
                                  // border: Border.all(
                                  //     color: AppColor().colorHonoluluBlue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: const Text(
                                AppStringConstants.loginScreenButtonTitle,
                                textAlign: TextAlign.center,
                                style: TextStyles.primaryButtonTextStyle,
                              ),
                            ),
                          );
                        },
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitButtonClick() {
    bloc.addUpdatePersonalDetails(
      onStart: () {
        SoLoader.showLoader();
      },
      onSuccess: () {
        SoLoader.hideLoader();
        // Navigator.of(context).pushNamedAndRemoveUntil(CongratulationsScreen.route, (route) => false,);
      },
      onFailure: (errorMessage) {
        SoLoader.hideLoader();
        if (mounted) {
          SoErrorWidget.showCIError(
            title: "Error",
            msg: errorMessage ?? "Something went wrong, Please try again later !!",
          );
        }
      },
    );
  }

  Widget profilePicture(Image imageFile) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _showPicker();
        },
        child: Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: imageFile.image,
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor().colorBlack,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(offset: const Offset(2, 4), color: Colors.black.withOpacity(0.3), blurRadius: 3,),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.edit, color: AppColor().colorWhite,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPicker() {
    final _picker = ImagePicker();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () async {
                        // Check camera permission
                        if (Platform.isIOS) {
                          if (await Permission.photos.request().isGranted) {
                            final pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 25,
                            );
                            if (pickedFile != null) {
                              setState(() {
                                bloc.imageFile = pickedFile;
                                bloc.uploadProfilePicture(file: pickedFile);
                                Navigator.of(context).pop();
                              });
                            } else {
                              // Handle case when user canceled image picking
                            }
                          } else if (await Permission
                              .photos.isPermanentlyDenied) {
                            // Show a dialog that explains why the camera permission is needed and provides a "Go to Settings" button
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                  const Text("Photo Library Permission Required"),
                                  content: const Text(
                                      "Please grant Photo Library permission to select photos."),
                                  actions: [
                                    TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Go to Settings"),
                                      onPressed: () {
                                        openAppSettings(); // Open the app settings page
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            // Handle the case where camera permission is denied, but not permanently
                            // You can request permission again using the permission package's request() method.
                          }
                        } else {
                          final pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 25,
                          );
                          if (pickedFile != null) {
                            setState(() {
                              bloc.imageFile = pickedFile;
                              bloc.uploadProfilePicture(file: pickedFile);
                              Navigator.of(context).pop();
                            });
                          }
                        }
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () async {
                      // Check camera permission
                      if (Platform.isIOS) {
                        if (await Permission.camera.request().isGranted) {
                          final pickedFile = await _picker.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 25,
                          );
                          if (pickedFile != null) {
                            setState(() {
                              bloc.imageFile = pickedFile;
                              bloc.uploadProfilePicture(file: pickedFile);
                              Navigator.of(context).pop();
                            });
                          } else {
                            // Handle case when user canceled image picking
                          }
                        } else if (await Permission
                            .camera.isPermanentlyDenied) {
                          // Show a dialog that explains why the camera permission is needed and provides a "Go to Settings" button
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Camera Permission Required"),
                                content: const Text(
                                    "Please grant camera permission to take photos."),
                                actions: [
                                  TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Go to Settings"),
                                    onPressed: () {
                                      openAppSettings(); // Open the app settings page
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Handle the case where camera permission is denied, but not permanently
                          // You can request permission again using the permission package's request() method.
                        }
                      } else {
                        final pickedFile = await _picker.pickImage(
                          source: ImageSource.camera,
                          imageQuality: 25,
                        );
                        if (pickedFile != null) {
                          setState(() {
                            bloc.imageFile = pickedFile;
                            bloc.uploadProfilePicture(file: pickedFile);
                            Navigator.of(context).pop();
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    primaryFocus?.unfocus();
    super.dispose();
  }
}
