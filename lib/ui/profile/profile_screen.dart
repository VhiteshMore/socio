import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socio/bloc/session_bloc.dart';
import 'package:socio/constant/app_string_constants.dart';
import 'package:socio/constant/args.dart';
import 'package:socio/ui/onboarding/personal_details_screen.dart';
import 'package:socio/ui/theme/app_colors.dart';
import 'package:socio/util/widget_utility.dart';

import '../../util/service_locator.dart';
import '../../util/user_data_helper.dart';
import '../theme/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  static const route = "ProfileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  UserDataHelper userDataHelper = injector<UserDataHelper>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorWhite,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PersonalDetailScreen.route, arguments: {Args.argIsRegistration: false, Args.argEmailId: SessionBloc.getEmail(), Args.argsUid: SessionBloc.getUserId()});
            },
            child: const Icon(Icons.edit, size: 20,),
          ),
          GestureDetector(
            child: const Icon(Icons.logout, size: 20,),
          )
        ],
      ),
      body: Container(
        color: AppColor().colorHonoluluBlue,
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: WidgetUtility.spreadWidgets([
                Image.asset('assets/images/avatar.png'),
                Row(
                  children: WidgetUtility.spreadWidgets([
                    Expanded(
                        child: _getUserInfoField(
                            AppStringConstants.profileEmailField,
                            userDataHelper.userAccountNotifier?.value.email ?? "--"))
                  ], interItemSpace: 10),
                ),
                Row(
                  children: WidgetUtility.spreadWidgets([
                    Expanded(
                        child: _getUserInfoField(
                            AppStringConstants.profileNameField,
                            "${userDataHelper.userAccountNotifier?.value.firstName ?? "--"} ${userDataHelper.userAccountNotifier?.value.lastName ?? "--"}"))
                  ], interItemSpace: 10),
                ),
                Row(
                  children: WidgetUtility.spreadWidgets([
                    Expanded(
                        child: _getUserInfoField(
                            AppStringConstants.profileBioField,
                            userDataHelper.userAccountNotifier?.value.bio ?? "....."))
                  ], interItemSpace: 10),
                ),
              ], flowHorizontal: false, interItemSpace: 15),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getUserInfoField(String fieldName, String fieldValue) {
    return Container(
      height: 52,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
          color: AppColor().colorNavyBlue,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: WidgetUtility.spreadWidgets([
          Text("$fieldName:", style: TextStyles.profileFieldText,),
          Expanded(child: Text(fieldValue, style: TextStyles.profileFieldText.copyWith(fontWeight: TextStyles.medium), maxLines: 1, overflow: TextOverflow.ellipsis,))
        ], interItemSpace: 2),
      ),
    );
  }

}
