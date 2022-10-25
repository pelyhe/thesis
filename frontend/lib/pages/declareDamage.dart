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

class DeclareDamagePage extends StatefulWidget {
  const DeclareDamagePage({Key? key}) : super(key: key);

  @override
  State<DeclareDamagePage> createState() => _DeclareDamagePageState();
}

class _DeclareDamagePageState extends State<DeclareDamagePage> {
  final controller = DeclareDamageController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
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
                  OutlinedButton(
                    onPressed: controller.pickFile,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                      side: MaterialStateProperty.all(BorderSide(
                          color: AppColors.navigationColor,
                          width: 1.5,
                          style: BorderStyle.solid)),
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(100, 35)),
                      maximumSize:
                          MaterialStateProperty.all<Size>(const Size(125, 35)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.folder,
                            color: AppColors.navigationColor, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          "Pick a file",
                          style: TextStyle(
                              color: AppColors.navigationColor, fontSize: 16),
                        ),
                      ],
                    ),
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
                            "If your demand is real, the compensation will be transfered to your eHUF account.",
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
                          onPressed: () {
                            // call declare damage sm. functio
                            print('OK.');
                            Get.toNamed("/");
                          },
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

  final FormControl totalDamageControl =
      FormControl<String>(validators: [Validators.required, Validators.number]);

  @override
  void onInit() {
    super.onInit();
    formGroup = FormGroup({totalDamage: totalDamageControl});
  }

  void pickFile() async {
    // TODO: share on IPFS
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    print(result!.files.first.name);
    if (result != null) {
    } else {
      // User canceled the picker
      print('cancelled');
    }
  }
}
