import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/UI/input/app_text_field.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_buttons.dart';

class EditRestaurantPage extends StatefulWidget {
  static const routeName = '/edit-restaurant';
  @override
  _EditRestaurantPageState createState() => _EditRestaurantPageState();
}

class _EditRestaurantPageState extends State<EditRestaurantPage> {
  final GlobalKey<FormState> _restaurantProfileFormKey = GlobalKey();

  Map<String, dynamic> formData = {
    'delivery_time': null,
    'minimum_order': null,
    'delivery_fee': null,
    'phone': null,
  };

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).get("Edit Restaurant Profile")),
      ),
      bodyPadding: const EdgeInsets.symmetric(horizontal: screenHorizontalPadding),
      body: SingleChildScrollView(
        child: Form(
          key: _restaurantProfileFormKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              AppTextField(
                labelText: "Delivery Time",
                initialValue: formData['delivery_time'],
                onSaved: (value) {
                  formData['delivery_time'] = value;
                },
              ),
              AppTextField(
                labelText: "Minimum Order",
                initialValue: formData['minimum_order'],
                onSaved: (value) {
                  formData['minimum_order'] = value;
                },
              ),
              AppTextField(
                labelText: "Delivery Fee",
                initialValue: formData['delivery_fee'],
                onSaved: (value) {
                  formData['delivery_fee'] = value;
                },
              ),
              AppTextField(
                labelText: "Phone Number",
                initialValue: formData['phone'],
                onSaved: (value) {
                  formData['phone'] = value;
                },
              ),
              AppButtons.primary(
                child: Text(Translations.of(context).get('Save')),
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
