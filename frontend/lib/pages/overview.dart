import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:get/get.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final controller = PaymentController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return GetBuilder<PaymentController>(
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
          children: const [
            Icon(Icons.info,
                size: 17, color: Color.fromARGB(255, 105, 103, 103)),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: AutoSizeText(
                "You have to pay the monthly fee until the 10th day of each month, unless your insurance will be invalid.",
                maxLines: 3,
                style: TextStyle(
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
              Text(
                "Pay the fees to reactivate your insurance.",
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 255, 17, 0)),
              )
            ],
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Center(
            child: OutlinedButton(
              onPressed: () {
                // call payMonthlyFee sm function
                print("pay monthly fee");
              },
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
                "Pay monthly fee",
                style:
                    TextStyle(color: AppColors.navigationColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
            showPlanCard('https://img.freepik.com/free-photo/abstract-luxury-gradient-blue-background-smooth-dark-blue-with-black-vignette-studio-banner_1258-52379.jpg?w=740&t=st=1667135947~exp=1667136547~hmac=510b3739b53da57d02d563f2160e09fd72f3f5de14c0b9c8e3eb48696286e1bc', 1, '2000', '20')
          else if (controller.currentPlan == 2)
            showPlanCard('https://img.freepik.com/free-photo/abstract-blur-empty-green-gradient-studio-well-use-as-backgroundwebsite-templateframebusiness-report_1258-54064.jpg?w=740&t=st=1667135980~exp=1667136580~hmac=b906fcb276bb97ea0c93f79c5375532e9695f671e242f845cb7c3ee49dc35843', 2, '4500', '50')
          else if (controller.currentPlan == 3)
            showPlanCard('https://img.freepik.com/free-photo/abstract-luxury-soft-red-background-christmas-valentines-layout-design-studio-room-web-template-business-report-with-smooth-circle-gradient-color_1258-54520.jpg?w=740&t=st=1667136021~exp=1667136621~hmac=1b33603b6aab646543dbc2d445f76f106a108b28009c49651f710f330f3c2b8f', 3, '7500', '100'),
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
                  style:
                      TextStyle(color: AppColors.navigationColor, fontSize: 20, fontWeight: FontWeight.bold),
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
    );
  }
}

class PaymentController extends GetxController {
  bool isInsuranceValid = true;
  int currentPlan = 2;
}
