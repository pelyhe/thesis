import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/components/payWithGitPopup.dart';
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10.0),
                  child: Row(
                    children: const [
                      Icon(Icons.warning,
                          size: 17, color: Color.fromARGB(255, 247, 16, 0)),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "Fees will be payed automatically after changing plan.",
                          style: TextStyle(
                              fontSize: 17, color: Color.fromARGB(255, 255, 17, 0)),
                        ),
                      )
                    ],
                  ),
                ),
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
                const SizedBox(
                  height: 40,
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
              ])),
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
              side: controller.currentPlan == i
                  ? BorderSide(color: AppColors.orange, width: 2.5)
                  : BorderSide.none),
          elevation: controller.currentPlan == i ? 30 : 10,
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

class ChangePlanController extends GetxController {
  int currentPlan = 2;

  setPlan(int p) {
    currentPlan = p;
    update();
  }

  submit(BuildContext context) {
    if (balanceIsNotNull()) {
      final res = getNumberOfUsableTokens();
      showDialog(
          context: context,
          builder: (BuildContext ctx) => PayWithTokens(
                tokenNumber: res,
              ));
    } else {
      // call changePlan sc function
      Get.toNamed('/overview');
    }
  }

  int getNumberOfUsableTokens() {
    // TODO: call sc function, which returns the number of tokens which can
    // be used for plan change

    // it returns 0, if no tokens, number of tokens if its not enoguh for plan change
    // and the number of tokens required for the plan change, if its less than balance
    return 3;
  }

  bool balanceIsNotNull() {
    // call sc similar function
    return true;
  }
}
