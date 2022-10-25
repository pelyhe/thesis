import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/general/themes.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  static int selectedIndex = 0;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final controller = BottomNavBarController();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: AppColors.navigationColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.file_open),
          label: 'Declare of damage',
          backgroundColor: AppColors.navigationColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.payments),
          label: 'Overview',
          backgroundColor: AppColors.navigationColor,
        ),
      ],
      currentIndex: BottomNavBar.selectedIndex,
      selectedItemColor: AppColors.orange,
      onTap: controller.onItemTapped,
    );
  }
}

class BottomNavBarController extends GetxController {
  void onItemTapped(int index) {
    BottomNavBar.selectedIndex = index;
    switch (index) {
      case 0:
        Get.toNamed('/');
        break;
      case 1:
        Get.toNamed('/declare-damage');
        break;
      case 2:
        Get.toNamed('/overview');
        break;
    }
    update();
  }
}
