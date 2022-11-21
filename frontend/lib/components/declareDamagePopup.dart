import 'dart:async';

import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/config/env.dart';
import 'package:formula/pages/error.dart';
import 'package:formula/service/authService.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DeclareDamagePopup extends StatefulWidget {
  final int numOfTokens;
  final String pictureIpfsHash, reportIpfsHash;
  final BigInt totalDamage;

  const DeclareDamagePopup({
    Key? key, 
    required this.numOfTokens, 
    required this.pictureIpfsHash, 
    required this.reportIpfsHash, 
    required this.totalDamage
  }) : super(key: key);

  @override
  State<DeclareDamagePopup> createState() => _DeclareDamagePopupState();
}

class _DeclareDamagePopupState extends State<DeclareDamagePopup> {
  @override
  Widget build(BuildContext context) {

    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: declareWithoutToken,
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: declareWithToken
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Use GIT tokens"),
      content: Text("Looks like you have ${widget.numOfTokens} GIT tokens. Would you like to use them for extra compensation?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return alert;
  }

  declareWithoutToken() async {
    final transaction = Transaction(
      to: Environment.contractAddress,
      from: AuthenticationService.instance.account,
      value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 0),
    );

    await launchUrlString("https://metamask.app.link/",
        mode: LaunchMode.externalApplication);

    try {
      await AuthenticationService.instance.contract!.declareDamage(
          AuthenticationService.instance.account!,
          widget.pictureIpfsHash,
          widget.reportIpfsHash,
          widget.totalDamage,
          credentials: AuthenticationService.instance.credentials!,
          transaction: transaction);
    } catch (error) {
      Get.to(ErrorScreen(errorDetails: error.toString()));
    }

    Timer(const Duration(seconds: 5), () => Get.toNamed('/splash'));
  }

  declareWithToken() async {
      final transaction = Transaction(
        to: Environment.contractAddress,
        from: AuthenticationService.instance.account,
        value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 0),
      );

      await launchUrlString("https://metamask.app.link/",
          mode: LaunchMode.externalApplication);

      try {
        await AuthenticationService.instance.contract!.declareDamageWithTokens(
            AuthenticationService.instance.account!,
            widget.pictureIpfsHash,
            widget.reportIpfsHash,
            widget.totalDamage,
            credentials: AuthenticationService.instance.credentials!,
            transaction: transaction
        ); 
      } catch (error) {
        Get.to(ErrorScreen(errorDetails: error.toString()));
      }

      Timer(const Duration(seconds: 5), () => Get.toNamed('/splash'));
  }

}