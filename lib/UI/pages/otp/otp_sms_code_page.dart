import 'dart:convert';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/app_wrapper.dart';
import 'package:tiptop_v2/UI/pages/otp/otp_complete_profile_page.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/UI/input/app_pin_code_text_field.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/providers/otp_provider.dart';
import 'package:tiptop_v2/utils/helper.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OTPSMSCodePage extends StatefulWidget {
  static const routeName = '/otp-step-three';

  @override
  _OTPSMSCodePageState createState() => _OTPSMSCodePageState();
}

class _OTPSMSCodePageState extends State<OTPSMSCodePage> {
  OTPProvider otpProvider;
  AppProvider appProvider;
  bool _isInit = true;
  String reference;
  DateTime validationDate;

  bool isValid;
  bool isNewUser;

  Map<String, dynamic> smsOTPData;
  String phoneCountryCode;
  String phoneNumber;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      otpProvider = Provider.of<OTPProvider>(context);
      appProvider = Provider.of<AppProvider>(context);
      final data = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      reference = data['reference'];
      phoneCountryCode = data['phone_country_code'];
      phoneNumber = data['phone_number'];
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: AppColors.white,
      bgImage: "assets/images/page-bg-pattern-white.png",
      body: Column(
        children: [
          const SizedBox(height: 40),
          Text(Translations.of(context).get('Check your messages')),
          const SizedBox(height: 15),
          Text(Translations.of(context).get('We sent a message to your number')),
          const SizedBox(height: 7),
          Text(
            '+$phoneCountryCode $phoneNumber',
            style: AppTextStyles.bodyBold,
            textDirection: TextDirection.ltr,
          ),
          Text(Translations.of(context).get('with verification code')),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: AppPinCodeTextField(
              length: 6,
              onComplete: (code) => _submitCode(code),
            ),
          ),
          const SizedBox(height: 20),
          CustomTimer(
            from: Duration(minutes: 3),
            to: Duration(minutes: 0),
            onBuildAction: CustomTimerAction.auto_start,
            onFinish: () {
              //Todo: implement duration end action
            },
            builder: (CustomTimerRemainingTime remaining) {
              return Text(
                "${remaining.minutes}:${remaining.seconds}",
                style: AppTextStyles.h2,
              );
            },
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Translations.of(context).get('Has it not arrived yet?'),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  //Todo: implement sending code again
                },
                child: Text(
                  Translations.of(context).get('Send again'),
                  style: AppTextStyles.bodySecondaryDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _submitCode(String code) async {
    final mobileAppDetails = await appProvider.loadMobileAppDetails();
    smsOTPData = {
      'phone_country_code': phoneCountryCode, // i.e: 90, 964
      'phone_number': phoneNumber,
      'code': code,
      'reference': reference,
      'mobile_app_details': json.encode(mobileAppDetails),
    };

    // try {
    await otpProvider.checkOTPSMSValidation(appProvider, smsOTPData);
    isValid = otpProvider.validationStatus;
    isNewUser = otpProvider.isNewUser;
    if (isValid == true) {
      if (isNewUser) {
        print('New user, navigating to complete profile page');
        Navigator.of(context).pushReplacementNamed(OTPCompleteProfile.routeName);
      } else {
        print('Registered user, navigating to home page');
        Navigator.of(context).pushReplacementNamed(AppWrapper.routeName);
      }
    } else {
      showToast(msg: 'OTP Validation Failed');
    }
/*    } catch (error) {
      showToast(msg: '${error.message != null ? error.message : 'Unknown error'}');
      throw error;
    }*/
  }
}