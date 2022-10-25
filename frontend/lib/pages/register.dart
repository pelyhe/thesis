import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:get/get.dart';

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
                  Text(
                    "You have to be older than 18 to take out an insurance.",
                    style: TextStyle(
                        fontSize: 17, color: Color.fromARGB(255, 255, 17, 0)),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Text(
                "Upload a picture of the frontside of your ID card",
                style:
                    TextStyle(fontSize: 20, color: AppColors.navigationColor),
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
              const SizedBox(height: 15),
              Text(
                "Upload a picture of the backside of your ID card",
                style:
                    TextStyle(fontSize: 20, color: AppColors.navigationColor),
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
              createPlanCard('blue-bg.jpg', 1, '2000', '20'),
              const SizedBox(height: 20),
              createPlanCard('green-bg.jpg', 2, '4500', '50'),
              const SizedBox(height: 20),
              createPlanCard('red-bg.jpg', 3, '7500', '100'),
              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        // call smart contract takeOutInsurance() function, then
                        // return to home page
                        print('OK.');
                        Get.toNamed("/");
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

  createPlanCard(String pictureName, int i, String price, String percentage) {
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
                image: AssetImage("images/$pictureName"),
                fit: BoxFit.fitWidth,
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
                      const SizedBox(height: 10,),
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
  int selectedNavIndex = 0;
  List<File>? idCardPictures;
  int plan = 1;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    print(result!.files.first.name);
    if (result != null) {
    } else {
      // User canceled the picker
      print('cancelled');
    }
  }

  setPlan(int p) {
    plan = p;
    update();
  }
}
