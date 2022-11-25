import 'dart:async';

import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:formula/config/env.dart';
import 'package:formula/pages/error.dart';
import 'package:formula/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResignPopup extends StatelessWidget {
  const ResignPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Resign"),
      onPressed:  () => resignInsurance(context)
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Resign insurance"),
      content: const Text("Are you sure want to resign your gas insurance?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return alert;
  }

  resignInsurance(BuildContext context) async {
    final transaction = Transaction(
      to: Environment.contractAddress,
      from: AuthenticationService.instance.account,
      value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 0),
    );

    await launchUrlString("https://metamask.app.link/",
        mode: LaunchMode.externalApplication);

    try {
      await AuthenticationService.instance.contract!.resignInsurance(
          credentials: AuthenticationService.instance.credentials!,
          transaction: transaction);
    } catch (error) {
      Get.to(ErrorScreen(errorDetails: error.toString()));
    }
    Navigator.of(context).pop(); // dismiss dialog
    Timer(const Duration(seconds: 2), () => Get.toNamed('/register'));
  }
}