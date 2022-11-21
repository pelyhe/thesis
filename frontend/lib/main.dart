import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:formula/general/route.dart';
import 'package:formula/pages/error.dart';
import 'package:formula/service/authService.dart';
import 'package:get/get.dart';
import 'package:formula/localization/localization.dart';
import 'general/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthenticationService(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightOrangeBackground,
      child: GetMaterialApp(
          builder: (context, child) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return const ErrorScreen(errorDetails: "Oops. Something went wrong!");
            };
            return child!;
          },
          theme: ThemeData(primaryColor: Colors.blue),
          translations: Languages(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          initialRoute: 'connect',
          getPages: AppRoutes.pages),
    );
  }

}
