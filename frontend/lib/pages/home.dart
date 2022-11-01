import 'package:flutter/material.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomePageController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return GetBuilder<HomePageController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.orange,
                title: const Text('Gas Insurance'),
              ),
              backgroundColor: Colors.transparent,
              body: scaffoldBody(
                context: context,
                mobileBody: mobileBody(),
                tabletBody: mobileBody(),
              ),
              bottomNavigationBar:
                  controller.isStatusActive ? const BottomNavBar() : null);
        });
  }

  Widget mobileBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
          child: Text(
            controller.isStatusActive
                ? "You have an active gas heating insurance."
                : "Currently you don't have an active gas heating insurance.",
            style: TextStyle(
                color: AppColors.navigationColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
        ),
        OutlinedButton(
          onPressed: !controller.isStatusActive
              ? () => Get.toNamed("/register")
              : () => Get.toNamed('/resign'),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            side: MaterialStateProperty.all(BorderSide(
                color: AppColors.orange, width: 2.5, style: BorderStyle.solid)),
            minimumSize: MaterialStateProperty.all<Size>(const Size(250, 80)),
          ),
          child: Text(
            !controller.isStatusActive ? "Take out insurance" : "Resign insurance",
            style: TextStyle(color: AppColors.navigationColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class HomePageController extends GetxController {
  bool isStatusActive = false;

  // TODO: isStatusActive = hasInsurance() function from sc

  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
