import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dart_web3/credentials.dart';
import 'package:dart_web3/dart_web3.dart';
import 'package:formula/config/env.dart';
import 'package:formula/pages/error.dart';
import 'package:formula/pages/loading.dart';
import 'package:formula/service/authService.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JudgeReportsPage extends StatefulWidget {
  const JudgeReportsPage({Key? key}) : super(key: key);

  @override
  State<JudgeReportsPage> createState() => _JudgeReportsPageState();
}

class _JudgeReportsPageState extends State<JudgeReportsPage> {
  final controller = JudgeReportsController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return FutureBuilder(
        future: controller.getPictureFromIpfs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return GetBuilder<JudgeReportsController>(
                init: controller,
                builder: (controller) {
                  return Scaffold(
                      appBar: AppBar(
                        backgroundColor: AppColors.orange,
                        title: const Text('Gas Insurance'),
                      ),
                      backgroundColor: Colors.transparent,
                      body: scaffoldBody(
                        context: context,
                        mobileBody: controller.picture == null
                            ? const ErrorScreen(
                                errorDetails: "No reports to be reviewed yet!")
                            : mobileBody(),
                        tabletBody: mobileBody(),
                      ),
                      bottomNavigationBar: const BottomNavBar());
                });
          }
        });
  }

  mobileBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Flexible(
          flex: 1,
          child: Text(
            "Is this damage valid?",
            style: TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 26),
          ),
        ),
        Flexible(
          flex: 6,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: controller.picture == null ? Container() : Image.file(File(controller.picture!.path))),
        ),
        Flexible(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                      child: Text("Not valid"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: controller.refuseReport),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    child: Text("Valid"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: controller.confirmReport,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class JudgeReportsController extends GetxController {
  File? picture;
  EthereumAddress? acc;

  getPictureFromIpfs() async {
    var res;
    try {
      res = await AuthenticationService.instance.contract!
          .getRandomDamagePicture();
    } catch (error) {
      Get.to(ErrorScreen(errorDetails: error.toString()));
    }
    if (res != null) {
      acc = res.var1;
      final path = res.var2;
      final url = 'http://vm.niif.cloud.bme.hu:14434/getFile?path=$path';
      final response = await http.get(Uri.parse(url));
      String header = response.headers['content-disposition']!;
      int fromIndex = header.indexOf('=');
      String filename = header.substring(fromIndex + 1);
      String dir = (await getApplicationDocumentsDirectory()).path;
      String filePath = '$dir/$filename';
      picture = await File(filePath).writeAsBytes(response.bodyBytes);
      update();
    }
  }

  confirmReport() async {
    final transaction = Transaction(
      to: Environment.contractAddress,
      from: AuthenticationService.instance.account,
      value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 0),
    );

    await launchUrlString("https://metamask.app.link/",
        mode: LaunchMode.externalApplication);

    await AuthenticationService.instance.contract!.confirmReport(
        AuthenticationService.instance.account!, acc!,
        credentials: AuthenticationService.instance.credentials!,
        transaction: transaction);
  }

  refuseReport() async {
    final transaction = Transaction(
      to: Environment.contractAddress,
      from: AuthenticationService.instance.account,
      value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 0),
    );

    await launchUrlString("https://metamask.app.link/",
        mode: LaunchMode.externalApplication);

    try {
      await AuthenticationService.instance.contract!.refuseReport(
          AuthenticationService.instance.account!, acc!,
          credentials: AuthenticationService.instance.credentials!,
          transaction: transaction);
    } catch (error) {
      Get.to(ErrorScreen(errorDetails: error.toString()));
    }
  }
}
