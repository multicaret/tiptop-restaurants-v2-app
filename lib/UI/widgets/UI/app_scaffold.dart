import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_loader.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final AppBar appBar;
  final EdgeInsetsGeometry bodyPadding;
  final String bgImage;
  final bool automaticallyImplyLeading;
  final bool hasCurve;
  final List<Widget> appBarActions;
  final bool hasOverlay;
  final bool hasOverlayLoader;
  final Color bgColor;

  const AppScaffold({
    this.body,
    this.appBar,
    this.bodyPadding,
    this.bgImage,
    this.automaticallyImplyLeading = true,
    this.hasCurve = true,
    this.appBarActions,
    this.hasOverlay = false,
    this.hasOverlayLoader = false,
    this.bgColor = AppColors.bg,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: AppColors.white,
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              color: AppColors.secondaryDark,
              child: Image.asset(
                'assets/images/appbar-bg-pattern.png',
                width: screenSize.width,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Scaffold(
            appBar: appBar ??
                AppBar(
                    automaticallyImplyLeading: automaticallyImplyLeading,
                    title: Image.asset(
                      'assets/images/tiptop-logo-title.png',
                      width: 77.42,
                      height: 26.84,
                    ),
                    actions: appBarActions),
            body: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(hasCurve ? 40 : 0),
                topRight: Radius.circular(hasCurve ? 40 : 0),
              ),
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                decoration: BoxDecoration(
                  color: bgColor,
                  image: bgImage != null
                      ? DecorationImage(
                          image: AssetImage(bgImage),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                padding: bodyPadding ?? EdgeInsets.all(0),
                child: body,
              ),
            ),
          ),
          if (hasOverlay)
            Positioned.fill(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: hasOverlay ? 1 : 0,
                child: Container(
                  color: AppColors.primary.withOpacity(0.8),
                ),
              ),
            ),
          if (hasOverlayLoader)
            Positioned.fill(
              child: Container(
                color: AppColors.primary.withOpacity(0.8),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.white.withOpacity(0.9),
                    ),
                    child: AppLoader(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}