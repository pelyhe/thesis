import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:formula/service/authService.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';

import 'loading.dart';

class ConnectWalletPage extends StatefulWidget {
  const ConnectWalletPage({Key? key}) : super(key: key);

  @override
  State<ConnectWalletPage> createState() => _ConnectWalletPageState();
}

class _ConnectWalletPageState extends State<ConnectWalletPage> {
  Future? futureCall;
  final controller = ConnectWalletController();

  @override
  void initState() {
    super.initState();
    futureCall = controller.checkWallet();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return FutureBuilder(
        future: futureCall,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return GetBuilder<ConnectWalletController>(
                init: controller,
                builder: (controller) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: scaffoldBody(
                      context: context,
                      mobileBody: mobileBody(),
                      tabletBody: mobileBody(),
                    ),
                  );
                });
          }
        });
  }

  Widget mobileBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Connect your wallet",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 30,
                color: AppColors.navigationColor),
          ),
          const SizedBox(
            height: 100,
          ),
          Image.asset(
            "images/login.png",
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 100,
          ),
          SliderButton(
              action: () async {
                await AuthenticationService.instance.connectWallet();
              },
              label: Text(
                "Slide to connect",
                style: TextStyle(
                    color: AppColors.navigationColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              icon: const Icon(Icons.arrow_right_alt_rounded))
        ],
      ),
    );
  }
}

class ConnectWalletController extends GetxController {
  Future<void> checkWallet() async {
    if (AuthenticationService.instance.isWalletConnected) {
      Get.toNamed('/');
    }
  }
}
