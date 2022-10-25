import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:get/get.dart';

class ChangePlanPage extends StatefulWidget {
  const ChangePlanPage({Key? key}) : super(key: key);

  @override
  State<ChangePlanPage> createState() => _ChangePlanPageState();
}

class _ChangePlanPageState extends State<ChangePlanPage> {
  final controller = ChangePlanController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return GetBuilder<ChangePlanController>(
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Text(
                      "Choose a plan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 28,
                          color: AppColors.navigationColor),
                    ),
                  ),
                ),
                createPlanCard('blue-bg.jpg', 1, '2000', '20'),
                const SizedBox(height: 20),
                createPlanCard('green-bg.jpg', 2, '4500', '50'),
                const SizedBox(height: 20),
                createPlanCard('red-bg.jpg', 3, '7500', '100'),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          // call changePlan sm function
                          print('OK.');
                          Get.toNamed("/overview");
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
              ])),
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
              side: controller.currentPlan == i
                  ? BorderSide(color: AppColors.orange, width: 2.5)
                  : BorderSide.none),
          elevation: controller.currentPlan == i ? 30 : 10,
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

class ChangePlanController extends GetxController {
  int currentPlan = 2;

  setPlan(int p) {
    currentPlan = p;
    update();
  }
}
