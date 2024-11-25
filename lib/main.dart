import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:instabug_flutter/CrashReporting.dart';
import 'package:instabug_flutter/InstabugNavigatorObserver.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/pages/language_select_page.dart';
import 'package:tiptop_v2/UI/pages/login_page.dart';
import 'package:tiptop_v2/providers.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/providers/local_storage.dart';
import 'package:tiptop_v2/routes.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

import 'UI/app_wrapper.dart';
import 'UI/splash_screen.dart';
import 'force_update_view.dart';
import 'i18n/translations.dart';

void main() async {
  await runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    };

    WidgetsFlutterBinding.ensureInitialized();
    LocalStorage().isReady().then((_) async {
      // Uncomment when you want to clear local storage on app launch
      // LocalStorage().clear();
      AppProvider appProvider = AppProvider();
      await appProvider.bootActions();
      runApp(MyApp(
        appProvider: appProvider,
      ));
    });
  }, (e, s) {
    CrashReporting.reportCrash(e, s);
  });
}

class MyApp extends StatefulWidget {
  final AppProvider appProvider;

  MyApp({this.appProvider});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _autoLoginFuture;

  @override
  void initState() {
    _autoLoginFuture = widget.appProvider.autoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: widget.appProvider,
        ),
        ...providers,
      ],
      child: Consumer<AppProvider>(
        builder: (c, app, _) => MaterialApp(
          navigatorObservers: [InstabugNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          title: 'TipTop',
          localizationsDelegates: [
            Translations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: app.appLocale,
          supportedLocales: app.appLanguages.map((language) => Locale(language.locale, language.countryCode)).toList(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: AppColors.primary,
            accentColor: AppColors.secondaryLight,
            scaffoldBackgroundColor: Colors.transparent,
            fontFamily: 'NeoSansArabic',
            textTheme: TextTheme(
              headline1: AppTextStyles.h2,
              button: AppTextStyles.button,
              bodyText1: AppTextStyles.body,
              bodyText2: AppTextStyles.body, //Default style everywhere, e.g. Text widget
            ),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              textTheme: TextTheme(
                headline1: AppTextStyles.h2,
                headline6: AppTextStyles.h2,
                bodyText1: AppTextStyles.body,
              ),
              iconTheme: IconThemeData(color: AppColors.primary, size: 20),
              actionsIconTheme: IconThemeData(color: AppColors.primary, size: 20),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primary,
                onPrimary: AppColors.white,
                minimumSize: Size.fromHeight(55),
                textStyle: AppTextStyles.button,
                elevation: 4,
                shadowColor: AppColors.shadowDark,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                ),
              ),
            ),
            sliderTheme: SliderThemeData(
              showValueIndicator: ShowValueIndicator.onlyForContinuous,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
              tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 6.0),
              activeTickMarkColor: AppColors.primary,
              inactiveTickMarkColor: AppColors.primary50,
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.primary50,
              thumbColor: AppColors.primary,
              valueIndicatorColor: AppColors.secondary,
            ),
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: AppColors.primary, textStyle: AppTextStyles.textButton)),
          ),
          home: getHomeWidget(app),
          routes: routes,
        ),
      ),
    );
  }

  Widget getHomeWidget(AppProvider app) {
    if (app.isForceUpdateEnabled) {
      return ForceUpdateWidget(
        appProvider: app,
      );
    }
    return app.localeSelected
        ? app.isAuth
            ? AppWrapper()
            : FutureBuilder(
                future: _autoLoginFuture,
                builder: (ctx, authResultSnapshot) =>
                    authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() : WalkthroughPage(),
              )
        : LanguageSelectPage();
  }
}
