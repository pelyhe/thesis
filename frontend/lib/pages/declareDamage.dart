import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dart_web3/dart_web3.dart';
import 'package:formula/components/declareDamagePopup.dart';
import 'package:formula/config/env.dart';
import 'package:formula/pages/error.dart';
import 'package:formula/pages/loading.dart';
import 'package:formula/service/authService.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:formula/components/AppTextField.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DeclareDamagePage extends StatefulWidget {
  const DeclareDamagePage({Key? key}) : super(key: key);

  @override
  State<DeclareDamagePage> createState() => _DeclareDamagePageState();
}

class _DeclareDamagePageState extends State<DeclareDamagePage> {
  final controller = DeclareDamageController();
  Future? initialize;

  @override
  void initState() {
    super.initState();
    initialize = controller.init();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return FutureBuilder(
        future: initialize,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return GetBuilder<DeclareDamageController>(
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
                      bottomNavigationBar: const BottomNavBar());
                });
          }
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
                      "Declare of damage",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 28,
                          color: AppColors.navigationColor),
                    ),
                  ),
                  Text(
                    "Upload the damage report",
                    style: TextStyle(
                        fontSize: 20, color: AppColors.navigationColor),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: controller.reportFile == null
                            ? controller.pickFile
                            : null,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey;
                              } else {
                                return Colors.transparent;
                              }
                            },
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          side: MaterialStateProperty.all(BorderSide(
                              color: AppColors.orange,
                              style: BorderStyle.solid)),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(100, 35)),
                          maximumSize: MaterialStateProperty.all<Size>(
                              const Size(125, 35)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.folder,
                                color: AppColors.navigationColor, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              "Pick a file",
                              style: TextStyle(
                                  color: AppColors.navigationColor,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      if (controller.reportFile != null)
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(controller.reportFile!.path
                                      .split('/')
                                      .last)),
                              IconButton(
                                  onPressed: controller.deleteReportFile,
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Upload a picture of the damage",
                    style: TextStyle(
                        fontSize: 20, color: AppColors.navigationColor),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: controller.pictureFile == null
                            ? controller.pickPicture
                            : null,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey;
                              } else {
                                return Colors.transparent;
                              }
                            },
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          side: MaterialStateProperty.all(BorderSide(
                              color: AppColors.orange,
                              style: BorderStyle.solid)),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(100, 35)),
                          maximumSize: MaterialStateProperty.all<Size>(
                              const Size(125, 35)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.folder,
                                color: AppColors.navigationColor, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              "Pick a file",
                              style: TextStyle(
                                  color: AppColors.navigationColor,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      if (controller.pictureFile != null)
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(controller.pictureFile!.path
                                      .split('/')
                                      .last)),
                              IconButton(
                                  onPressed: controller.deletePictureFile,
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "How much is your total damage?",
                    style: TextStyle(
                        fontSize: 17, color: AppColors.navigationColor),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: AppTextField(
                        control: controller.totalDamageControl,
                        hint: 'Enter total damage (eHUF)',
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: ScreenSize.width,
                    child: Row(
                      children: const [
                        Icon(Icons.info,
                            size: 17,
                            color: Color.fromARGB(255, 105, 103, 103)),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            "If your demand is valid, the compensation will be transfered to your eHUF account.",
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 105, 103, 103)),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: ElevatedButton(
                          onPressed: () => controller.submit(context),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
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
                ])));
  }
}

class DeclareDamageController extends GetxController {
  late FormGroup formGroup;
  String totalDamage = "";
  File? reportFile;
  File? pictureFile;
  String? reportIpfsPath, pictureIpfsPath;
  int? numberOfTokens;

  final FormControl totalDamageControl =
      FormControl<String>(validators: [Validators.required, Validators.number]);

  @override
  void onInit() {
    super.onInit();
    formGroup = FormGroup({totalDamage: totalDamageControl});
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'xlsx'],
    );
    if (result != null) {
      reportFile = File(result.files.last.path!);
      update();
    } else {
      print('cancelled');
    }
  }

  void pickPicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
    );
    if (result != null) {
      pictureFile = File(result.files.last.path!);
      update();
    } else {
      print('cancelled');
    }
  }

  void deleteReportFile() {
    reportFile = null;
    update();
  }

  void deletePictureFile() {
    pictureFile = null;
    update();
  }

  init() async {
    BigInt gitTokensResult = await AuthenticationService.instance.contract!
        .balanceOf(AuthenticationService.instance.account!);
    numberOfTokens = gitTokensResult.toInt();
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
          pictureIpfsPath!,
          reportIpfsPath!,
          BigInt.from(int.parse(totalDamageControl.value)),
          credentials: AuthenticationService.instance.credentials!,
          transaction: transaction);
    } catch (error) {
      Get.to(ErrorScreen(errorDetails: error.toString()));
    }

    Timer(const Duration(seconds: 2), () => Get.toNamed('/splash'));
  }

  Future<void> submit(BuildContext context) async {
    if (reportFile != null && pictureFile != null && totalDamageControl.valid) {
      var str = await shareReportOnIpfs();
      await sharePictureOnIpfs(str);
      numberOfTokens == 0 ? 
      declareWithoutToken() :
      showDialog(
          context: context,
          builder: (BuildContext ctx) => DeclareDamagePopup(
              numOfTokens: numberOfTokens!,
              pictureIpfsHash: pictureIpfsPath!,
              reportIpfsHash: reportIpfsPath!,
              totalDamage: BigInt.from(int.parse(totalDamageControl.value))));
    } else {
      const snackBar = SnackBar(
        content:
            Text("Please fill all fields.", style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> sharePictureOnIpfs(contractString) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://vm.niif.cloud.bme.hu:14434/storeFile?id=$contractString"));
    request.files.add(http.MultipartFile('file',
        pictureFile!.readAsBytes().asStream(), pictureFile!.lengthSync(),
        filename: pictureFile!.path.split('/').last));
    var res = await request.send();
    final resBody = await res.stream.bytesToString();
    pictureIpfsPath = jsonDecode(resBody)['path'];
  }

  Future<String> shareReportOnIpfs() async {
    final contractString = getRandomString(20);
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://vm.niif.cloud.bme.hu:14434/storeFile?id=$contractString"));
    request.files.add(http.MultipartFile(
        'file', reportFile!.readAsBytes().asStream(), reportFile!.lengthSync(),
        filename: reportFile!.path.split('/').last));
    var res = await request.send();
    final resBody = await res.stream.bytesToString();
    reportIpfsPath = jsonDecode(resBody)['path'];
    return contractString;
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random.secure();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}
