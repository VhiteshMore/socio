import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:socio/constant/args.dart';
import 'package:socio/ui/onboarding/personal_details_screen.dart';


import '../../constant/app_string_constants.dart';
import '../../util/widget_utility.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/so_error_widget.dart';
import '../widgets/so_loader.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const route = "LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginBloc bloc = LoginBloc();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: Navigator.of(context).canPop() ? GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.arrow_back_ios, size: 20,),
          ),
        ) : null,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: WidgetUtility.spreadWidgets([
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: WidgetUtility.spreadWidgets([
                        CustomTextField(
                          headerLabel: AppStringConstants.emailTextField,
                          hintText: AppStringConstants.emailHintText,
                          controller: bloc.emailTextController,
                          textInputType: TextInputType.emailAddress,
                        ),
                        CustomTextField(
                          headerLabel: AppStringConstants.passTextField,
                          hintText: AppStringConstants.passHintText,
                          controller: bloc.passTextController,
                          textInputType: TextInputType.text,
                          obscureText: true,
                        )
                      ], interItemSpace: 12, flowHorizontal: false),
                    ),
                  ),
                ], interItemSpace: 20, flowHorizontal: false),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: bloc.buttonEnabledNotifier,
                        builder: (context, isValid, _) {
                          return GestureDetector(
                            onTap: () {
                              loginButtonClick();
                            },
                            child: Container(
                              height: 52,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: isValid ? AppColor().colorHonoluluBlue : AppColor().colorHonoluluBlue.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: const Text(
                                AppStringConstants.loginScreenButtonTitle,
                                textAlign: TextAlign.center,
                                style: TextStyles.primaryButtonTextStyle,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void loginButtonClick() {
    bloc.userLogin(
      password: bloc.passTextController.text,
      email: bloc.emailTextController.text,
      onStart: () {
        SoLoader.showLoader();
      },
      onSuccess: ({required userRegistered, required uid}) {
          SoLoader.hideLoader();
          if (userRegistered) {

          } else {
            Navigator.of(context).pushNamed(PersonalDetailScreen.route, arguments: {Args.argIsRegistration: true, Args.argEmailId: bloc.emailTextController.text, Args.argsUid: uid});
          }
      },
      onFailure: (errorMessage) {
        SoLoader.hideLoader();
        if (mounted) {
          SoErrorWidget.showCIError(
            title: "Login Error",
            msg: errorMessage ?? "Something went wrong, Please try again later.",
          );
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}
