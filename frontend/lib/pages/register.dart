import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dart_web3/dart_web3.dart';
import 'package:formula/config/env.dart';
import 'package:formula/pages/error.dart';
import 'package:formula/service/authService.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:formula/pages/loading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = RegisterPageController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return GetBuilder<RegisterPageController>(
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
              mobileBody: mobileBody(),
              tabletBody: mobileBody(),
            ),
          );
        });
  }

  mobileBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  "Taking out insurance",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 28,
                      color: AppColors.navigationColor),
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.warning,
                      size: 17, color: Color.fromARGB(255, 247, 16, 0)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "You have to be older than 18 to take out an insurance.",
                      style: TextStyle(
                          fontSize: 17, color: Color.fromARGB(255, 255, 17, 0)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: controller.pickFrontside,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                      side: MaterialStateProperty.all(BorderSide(
                          color: AppColors.navigationColor,
                          width: 1.5,
                          style: BorderStyle.solid)),
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(165, 35)),
                      maximumSize:
                          MaterialStateProperty.all<Size>(const Size(180, 35)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.perm_identity,
                            color: AppColors.navigationColor, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          "Front side of your ID",
                          style: TextStyle(
                              color: AppColors.navigationColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (controller.frontside != null)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  controller.frontside!.path.split('/').last)),
                          IconButton(
                              onPressed: controller.deleteFrontside,
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    )
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: controller.pickBackside,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                      side: MaterialStateProperty.all(BorderSide(
                          color: AppColors.navigationColor,
                          width: 1.5,
                          style: BorderStyle.solid)),
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(165, 35)),
                      maximumSize:
                          MaterialStateProperty.all<Size>(const Size(180, 35)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.perm_identity,
                            color: AppColors.navigationColor, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          "Back side of your ID",
                          style: TextStyle(
                              color: AppColors.navigationColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (controller.backside != null)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  controller.backside!.path.split('/').last)),
                          IconButton(
                              onPressed: controller.deleteBackside,
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    )
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Choose your plan",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 22,
                    color: AppColors.navigationColor),
              ),
              const SizedBox(height: 20),
              createPlanCard(
                  'https://img.freepik.com/free-photo/abstract-luxury-gradient-blue-background-smooth-dark-blue-with-black-vignette-studio-banner_1258-52379.jpg?w=740&t=st=1667135947~exp=1667136547~hmac=510b3739b53da57d02d563f2160e09fd72f3f5de14c0b9c8e3eb48696286e1bc',
                  1,
                  '2000',
                  '20'),
              const SizedBox(height: 20),
              createPlanCard(
                  'https://img.freepik.com/free-photo/abstract-blur-empty-green-gradient-studio-well-use-as-backgroundwebsite-templateframebusiness-report_1258-54064.jpg?w=740&t=st=1667135980~exp=1667136580~hmac=b906fcb276bb97ea0c93f79c5375532e9695f671e242f845cb7c3ee49dc35843',
                  2,
                  '4500',
                  '50'),
              const SizedBox(height: 20),
              createPlanCard(
                  'https://img.freepik.com/free-photo/abstract-luxury-soft-red-background-christmas-valentines-layout-design-studio-room-web-template-business-report-with-smooth-circle-gradient-color_1258-54520.jpg?w=740&t=st=1667136021~exp=1667136621~hmac=1b33603b6aab646543dbc2d445f76f106a108b28009c49651f710f330f3c2b8f',
                  3,
                  '7500',
                  '100'),
              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        // call smart contract takeOutInsurance() function, then
                        // return to home page
                        controller.submit(context);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.orange),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(125, 60)),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: AppColors.navigationColor, fontSize: 20),
                      ),
                    )),
              )
            ]),
      ),
    );
  }

  createPlanCard(String pictureUri, int i, String price, String percentage) {
    return InkWell(
      onTap: () => controller.setPlan(i),
      child: SizedBox(
        width: ScreenSize.width - 60,
        height: 200,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: controller.plan == i
                  ? BorderSide(color: AppColors.orange, width: 2.5)
                  : BorderSide.none),
          elevation: controller.plan == i ? 30 : 10,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(pictureUri),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'PLAN $i',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 2,
                        color: Colors.white),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$price eHUF',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                      const Text(
                        'monthly',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$percentage% compensation',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPageController extends GetxController {
  int plan = 1;
  String? insuranceCompany;
  File? frontside, backside;

  void pickFrontside() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
    );
    if (result != null) {
      frontside = File(result.files.last.path!);
      update();
    } else {
      print('cancelled');
    }
  }

  void pickBackside() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
    );
    if (result != null) {
      backside = File(result.files.last.path!);
      update();
    } else {
      print('cancelled');
    }
  }

  setPlan(int p) {
    plan = p;
    update();
  }

  void deleteFrontside() {
    frontside = null;
    update();
  }

  void deleteBackside() {
    backside = null;
    update();
  }

  Future<void> submit(BuildContext context) async {
    if (frontside != null && backside != null) {
      var str = await shareFrontsideOnIpfs();
      await shareBacksideOnIpfs(str);
      takeOutInsurance();
    } else {
      const snackBar = SnackBar(
        content: Text("You have to upload both files.",
            style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void takeOutInsurance() async {
    final transaction = Transaction(
      to: Environment.contractAddress,
      from: AuthenticationService.instance.account,
      value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 0),
    );

    await launchUrlString("https://metamask.app.link/",
        mode: LaunchMode.externalApplication);

    try {
      await AuthenticationService.instance.contract!
          .takeOutInsurance(
              AuthenticationService.instance.account!, BigInt.from(plan),
              credentials: AuthenticationService.instance.credentials!,
              transaction: transaction);
    } catch (error) {
      Get.to(ErrorScreen(errorDetails: error.toString()));
    }
    
    Timer(const Duration(seconds: 5), BottomNavBar.toOverview);
    
  }

  shareFrontsideOnIpfs() async {
    final contractString = getRandomString(20);
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://vm.niif.cloud.bme.hu:14434/storeFile?id=$contractString"));
    request.files.add(http.MultipartFile(
        'file', frontside!.readAsBytes().asStream(), frontside!.lengthSync(),
        filename: frontside!.path.split('/').last));
    await request.send();
    return contractString;
  }

  shareBacksideOnIpfs(String contractString) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://vm.niif.cloud.bme.hu:14434/storeFile?id=$contractString"));
    request.files.add(http.MultipartFile(
        'file', backside!.readAsBytes().asStream(), backside!.lengthSync(),
        filename: backside!.path.split('/').last));
    var res = await request.send();
    final resBody = await res.stream.bytesToString();
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random.secure();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}
