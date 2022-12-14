import 'package:auto_size_text/auto_size_text.dart';
import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:formula/components/bottom_nav_bar.dart';
import 'package:formula/components/resign_popup.dart';
import 'package:formula/config/env.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:formula/pages/error.dart';
import 'package:formula/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'loading.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final controller = OverviewController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return FutureBuilder(
        future: controller.init(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return GetBuilder<OverviewController>(
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
                  createPaymentSection(),
                  const Divider(height: 2),
                  const SizedBox(height: 30),
                  createPlanSection()
                ])));
  }

  createPaymentSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "Your insurance status is ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 28,
                      color: AppColors.navigationColor),
                ),
                TextSpan(
                  text: controller.isInsuranceValid ? "valid" : "invalid",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 28,
                      color: controller.isInsuranceValid
                          ? Colors.green
                          : Colors.red),
                )
              ]),
            ),
          ),
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/git.png",
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: AutoSizeText(
                "${controller.gitTokens} GIT tokens",
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Icon(Icons.info,
                size: 17, color: Color.fromARGB(255, 105, 103, 103)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: AutoSizeText(
                controller.daysLeft > 0 ? "You have ${controller.daysLeft} days until the next payment" :
                controller.hoursLeft > 0 ? "You have ${controller.hoursLeft} hours until the next payment" :
                controller.minutesLeft > 0 ?  "You have ${controller.minutesLeft} minutes until the next payment" :
                "Your payment is due, please pay your fees.",
                maxLines: 3,
                style: const TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 105, 103, 103)),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        if (!controller.isInsuranceValid)
          Row(
            children: const [
              Icon(Icons.warning,
                  size: 17, color: Color.fromARGB(255, 247, 16, 0)),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Pay the fees to reactivate your insurance.",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 255, 17, 0)),
                ),
              )
            ],
          ),
        Row(
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
                child: Center(
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) => const ResignPopup());
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Colors.red,
                          width: 2.5,
                          style: BorderStyle.solid)),
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(170, 64)),
                    ),
                    child: Center(
                      child: AutoSizeText(
                        "Resign insurance",
                        maxLines: 2,
                        style: TextStyle(
                            color: AppColors.navigationColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
                child: Center(
                  child: OutlinedButton(
                    onPressed: () => controller.payMonthlyFee(context),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                      side: MaterialStateProperty.all(BorderSide(
                          color: AppColors.orange,
                          width: 2.5,
                          style: BorderStyle.solid)),
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(220, 64)),
                    ),
                    child: Text(
                      "Pay monthly fee",
                      style: TextStyle(
                          color: AppColors.navigationColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  createPlanSection() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Text(
                "Your plan",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 28,
                    color: AppColors.navigationColor),
              ),
            ),
          ),
          if (controller.currentPlan == 1)
            showPlanCard(
                'https://img.freepik.com/free-photo/abstract-luxury-gradient-blue-background-smooth-dark-blue-with-black-vignette-studio-banner_1258-52379.jpg?w=740&t=st=1667135947~exp=1667136547~hmac=510b3739b53da57d02d563f2160e09fd72f3f5de14c0b9c8e3eb48696286e1bc',
                1,
                '2500',
                '20')
          else if (controller.currentPlan == 2)
            showPlanCard(
                'https://img.freepik.com/free-photo/abstract-blur-empty-green-gradient-studio-well-use-as-backgroundwebsite-templateframebusiness-report_1258-54064.jpg?w=740&t=st=1667135980~exp=1667136580~hmac=b906fcb276bb97ea0c93f79c5375532e9695f671e242f845cb7c3ee49dc35843',
                2,
                '4500',
                '50')
          else if (controller.currentPlan == 3)
            showPlanCard(
                'https://img.freepik.com/free-photo/abstract-luxury-soft-red-background-christmas-valentines-layout-design-studio-room-web-template-business-report-with-smooth-circle-gradient-color_1258-54520.jpg?w=740&t=st=1667136021~exp=1667136621~hmac=1b33603b6aab646543dbc2d445f76f106a108b28009c49651f710f330f3c2b8f',
                3,
                '7500',
                '100'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Center(
              child: OutlinedButton(
                onPressed: () => Get.toNamed("/change-plan"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                  side: MaterialStateProperty.all(BorderSide(
                      color: AppColors.orange,
                      width: 2.5,
                      style: BorderStyle.solid)),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(200, 64)),
                ),
                child: Text(
                  "Change plan",
                  style: TextStyle(
                      color: AppColors.navigationColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ]);
  }

  showPlanCard(String pictureUri, int i, String price, String percentage) {
    return SizedBox(
      width: ScreenSize.width - 60,
      height: 200,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
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
    );
  }
}

class OverviewController extends GetxController {
  bool isInsuranceValid = false;
  int currentPlan = 1;
  int daysLeft = 0, hoursLeft = 0, minutesLeft = 0; // getNextPayment - now() in unix time
  int gitTokens = 0;

  init() async {
    isInsuranceValid = await AuthenticationService.instance.contract!
        .isInsuranceActive(AuthenticationService.instance.account!);
    BigInt currentPlanResult = await AuthenticationService.instance.contract!
        .getPlan(AuthenticationService.instance.account!);
    currentPlan = currentPlanResult.toInt();
    BigInt nextPaymentResult = await AuthenticationService.instance.contract!
        .getNextPaymentDate(AuthenticationService.instance.account!);
    DateTime nextPaymentDate =
        DateTime.fromMillisecondsSinceEpoch(nextPaymentResult.toInt() * 1000);
    daysLeft = nextPaymentDate.difference(DateTime.now()).inDays;
    hoursLeft = nextPaymentDate.difference(DateTime.now()).inHours;
    minutesLeft = nextPaymentDate.difference(DateTime.now()).inMinutes;
    BigInt gitTokensResult = await AuthenticationService.instance.contract!
        .balanceOf(AuthenticationService.instance.account!);
    gitTokens = gitTokensResult.toInt();
  }

  payMonthlyFee(BuildContext context) async {
    final transaction = Transaction(
      to: Environment.contractAddress,
      from: AuthenticationService.instance.account,
      value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 0),
    );

    await launchUrlString("https://metamask.app.link/",
        mode: LaunchMode.externalApplication);

    try {
      await AuthenticationService.instance.contract!.payMonthlyFee(
          AuthenticationService.instance.account!,
          credentials: AuthenticationService.instance.credentials!,
          transaction: transaction);
    } catch (error) {
      Get.to(ErrorScreen(errorDetails: error.toString()));
    }

  }


}
