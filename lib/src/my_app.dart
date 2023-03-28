import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/src/util/app_constant.dart';
import 'screen/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return AdaptiveTheme(
              light: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.blue,
                  accentColor: Colors.amber),
              // dark: ThemeData(
              //   brightness: Brightness.dark,
              //   primarySwatch: Colors.red,
              //   accentColor: Colors.amber,
              // ),
              initial: AdaptiveThemeMode.light,
              builder: (theme, darkTheme) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  // darkTheme: darkTheme,
                  home: HomePage(),
                );
              });
        });
  }
}
