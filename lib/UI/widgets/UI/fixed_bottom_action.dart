import 'package:flutter/material.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';

class FixedBottomAction extends StatelessWidget {
  final Widget child;

  FixedBottomAction({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: actionButtonContainerHeight,
      decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
      padding: const EdgeInsets.only(
        right: screenHorizontalPadding,
        left: screenHorizontalPadding,
        bottom: actionButtonBottomPadding,
        top: listItemVerticalPadding,
      ),
      child: child,
    );
  }
}
