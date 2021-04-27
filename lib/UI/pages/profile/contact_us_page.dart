import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/UI/input/app_text_field.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_buttons.dart';

class ContactUsPage extends StatefulWidget {
  static const routeName = '/contact-us';
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final GlobalKey<FormState> _contactUsFormKey = GlobalKey();

  Map<String, dynamic> contactUsFormData = {
    'name': null,
    'phone': null,
    'email': null,
    'subject': null,
    'message': null,
  };

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasCurve: true,
      appBar: AppBar(
        title: Text(Translations.of(context).get("Contact Us")),
      ),
      bodyPadding: const EdgeInsets.symmetric(horizontal: screenHorizontalPadding),
      body: SingleChildScrollView(
        child: Form(
          key: _contactUsFormKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              AppTextField(
                labelText: "Name",
                textInputAction: TextInputAction.next,
                initialValue: contactUsFormData['name'],
                onSaved: (value) {
                  contactUsFormData['name'] = value;
                },
              ),
              AppTextField(
                labelText: "Phone Number",
                textInputAction: TextInputAction.next,
                initialValue: contactUsFormData['phone'],
                onSaved: (value) {
                  contactUsFormData['phone'] = value;
                },
              ),
              AppTextField(
                textDirection: TextDirection.ltr,
                labelText: "Email",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                initialValue: contactUsFormData['email'],
                onSaved: (value) {
                  contactUsFormData['email'] = value;
                },
              ),
              AppTextField(
                labelText: "Subject",
                textInputAction: TextInputAction.next,
                initialValue: contactUsFormData['subject'],
                onSaved: (value) {
                  contactUsFormData['subject'] = value;
                },
              ),
              AppTextField(
                labelText: "Message",
                textInputAction: TextInputAction.done,
                initialValue: contactUsFormData['message'],
                maxLines: 4,
                onSaved: (value) {
                  contactUsFormData['message'] = value;
                },
              ),
              AppButtons.primary(
                child: Text(Translations.of(context).get('Submit')),
                onPressed: () {
                  //submit form
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
