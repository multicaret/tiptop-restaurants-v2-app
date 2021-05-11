import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/app_wrapper.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/UI/input/app_text_field.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/helper.dart';
import 'package:tiptop_v2/utils/http_exception.dart';
import 'package:tiptop_v2/utils/styles/app_buttons.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class WalkthroughPage extends StatefulWidget {
  static const routeName = '/walkthrough';

  @override
  _WalkthroughPageState createState() => _WalkthroughPageState();
}

class _WalkthroughPageState extends State<WalkthroughPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> loginData = {
    'email': '',
    'password': '',
  };

  bool _isLoading = false;
  AppProvider appProvider;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    appProvider = Provider.of<AppProvider>(context);

    return AppScaffold(
      bodyPadding: const EdgeInsets.symmetric(horizontal: screenHorizontalPadding),
      bgColor: AppColors.white,
      hasOverlayLoader: _isLoading,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Image.asset(
                'assets/images/tiptop-logo.png',
                width: screenSize.width / 2.5,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Translations.of(context).get('Login'),
                    style: AppTextStyles.h1,
                  ),
                  SizedBox(height: 12),
                  Text(Translations.of(context).get('Please enter your account information')),
                  SizedBox(height: 50),
                  AppTextField(
                    labelText: 'Email',
                    textDirection: TextDirection.ltr,
                    //remove later
                    initialValue: ''
                    // 'owner@trytiptop.app'
                    ,
                    onSaved: (value) {
                      loginData['email'] = value;
                    },
                  ),
                  AppTextField(
                    labelText: 'Password',
                    isPassword: true,
                    textDirection: TextDirection.ltr,
                    initialValue: ''
                    // 'secret'
                    ,
                    onSaved: (value) {
                      loginData['password'] = value;
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            AppButtons.primary(
              child: Text(Translations.of(context).get('Login')),
              onPressed: _isLoading ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    String msg;
    if (!_formKey.currentState.validate()) {
      msg = Translations.of(context).get('Invalid Form');
      showToast(msg: msg);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState.save();
    try {
      await appProvider.login(loginData['email'], loginData['password']);
      Navigator.push(context, MaterialPageRoute(builder: (context) => AppWrapper()));
      msg = Translations.of(context).get('Login Successful');
      showToast(msg: msg);
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      appAlert(context: context, title: 'An Error Occurred', description: error.getErrorsAsString()).show();
      setState(() => _isLoading = false);
    }  catch (error) {
      msg = Translations.of(context).get('An Error Occurred');
      showToast(msg: msg);
      setState(() => _isLoading = false);
      throw error;
    }
  }
}
