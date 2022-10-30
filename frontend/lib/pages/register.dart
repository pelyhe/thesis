import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:get/get.dart';
import 'package:trinsic_dart/trinsic.dart';
//import 'package:trinsic_dart/src/trinsic_service.dart';
//import 'package:trinsic_dart/src/trinsic_util.dart';

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
              /*const SizedBox(height: 8),
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
              ),*/
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
              createPlanCard('https://img.freepik.com/free-photo/abstract-luxury-gradient-blue-background-smooth-dark-blue-with-black-vignette-studio-banner_1258-52379.jpg?w=740&t=st=1667135947~exp=1667136547~hmac=510b3739b53da57d02d563f2160e09fd72f3f5de14c0b9c8e3eb48696286e1bc', 1, '2000', '20'),
              const SizedBox(height: 20),
              createPlanCard('https://img.freepik.com/free-photo/abstract-blur-empty-green-gradient-studio-well-use-as-backgroundwebsite-templateframebusiness-report_1258-54064.jpg?w=740&t=st=1667135980~exp=1667136580~hmac=b906fcb276bb97ea0c93f79c5375532e9695f671e242f845cb7c3ee49dc35843', 2, '4500', '50'),
              const SizedBox(height: 20),
              createPlanCard('https://img.freepik.com/free-photo/abstract-luxury-soft-red-background-christmas-valentines-layout-design-studio-room-web-template-business-report-with-smooth-circle-gradient-color_1258-54520.jpg?w=740&t=st=1667136021~exp=1667136621~hmac=1b33603b6aab646543dbc2d445f76f106a108b28009c49651f710f330f3c2b8f', 3, '7500', '100'),
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
  int selectedNavIndex = 0;
  List<File>? idCardPictures;
  int plan = 1;

  /*Future<void> setupTrinsic() async {
    var trinsic = TrinsicService(trinsicConfig(), null);
    var ecosystem = await trinsic.provider().createEcosystem();
    var insuranceCompany = await trinsic.account().signIn();
    trinsic.serviceOptions.authToken = insuranceCompany;
    var info = await trinsic.account().getInfo();
    print("Account info=$info");
  }*/

  Future<void> pickFile() async {
    /*FilePickerResult? result = await FilePicker.platform.pickFiles();
    print(result!.files.first.name);
    if (result != null) {
    } else {
      // User canceled the picker
      print('cancelled');
    }*/
  }

  setPlan(int p) {
    plan = p;
    update();
  }
}
