import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/api/di/di.dart' as di;
import 'package:weather_app/pages/weather/weather_page.dart';
import 'constants/strings.dart';
import 'generated/l10n.dart';

void main() {
  startApp();
}

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
            DeviceOrientation.portraitDown,
            DeviceOrientation.portraitUp
          ]);
          SizerUtil.setScreenSize(
              constraints, orientation); //initialize SizerUtil
          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: Strings.APP_NAME,
            home: WeatherPage(),
          );
        },
      );
    });
  }
}
