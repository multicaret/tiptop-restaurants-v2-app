import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/UI/input/app_text_field.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/models/models.dart';
import 'package:tiptop_v2/utils/helper.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';

import 'app_alert_dialog.dart';

class TextFieldDialog extends StatefulWidget {
  final String title;
  final String image;
  final String textFieldLabel;
  final TextEditingController controller;
  final TextInputType keyboardType;

  TextFieldDialog({
    this.title,
    this.image,
    this.textFieldLabel,
    this.controller,
    this.keyboardType,
  });

  @override
  _TextFieldDialogState createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {
  TextEditingController textFieldController = TextEditingController();
  String textFieldValue = '';
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppAlertDialog(
      children: [
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: AppTextField(
            controller: textFieldController,
            labelText: widget.textFieldLabel,
            hasInnerLabel: true,
            onSaved: (value) => textFieldValue = value,
            required: true,
            fit: true,
            keyboardType: widget.keyboardType,
          ),
        ),
      ],
      actions: [
        DialogAction(
          text: 'Done',
          buttonColor: AppColors.secondary,
          onTap: _submit,
        ),
        DialogAction(
          text: 'Cancel',
          popValue: false,
        ),
      ],
    );
  }

  void _submit() {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      showToast(msg: Translations.of(context).get('Please enter a value!'));
      return;
    }
    Navigator.of(context).pop(textFieldValue);
  }
}
