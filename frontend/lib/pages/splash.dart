import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/config/env.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/pages/overview.dart';
import 'package:formula/pages/register.dart';
import 'package:formula/service/authService.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'loading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = SplashController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return FutureBuilder(
        future: controller.loadInsurance(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return GetBuilder<SplashController>(
                init: controller,
                builder: (controller) {
                  return controller.hasInsurance!
                      ? const OverviewPage()
                      : const RegisterPage();
                });
          }
        });
  }
}

class SplashController extends GetxController {
  bool? hasInsurance;

  loadInsurance() async {
    // call hasInsurance from GasInsuranceToken
    hasInsurance = await AuthenticationService.instance.contract!.hasInsurance(AuthenticationService.instance.account!);
    
    update();
  }
}
