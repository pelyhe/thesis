import 'package:formula/pages/changePlan.dart';
import 'package:formula/pages/connectWallet.dart';
import 'package:formula/pages/declareDamage.dart';
import 'package:formula/pages/home.dart';
import 'package:formula/pages/overview.dart';
import 'package:formula/pages/register.dart';
import 'package:get/get.dart';

class AppRoutes {
  static String home = "/";
  static String connectWallet = "/connect";
  static String register = "/register";
  static String declareDamage = "/declare-damage";
  static String overview = "/overview";
  static String changePlan = "/change-plan";

  static final pages = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: connectWallet, page: () => const ConnectWalletPage()),
    GetPage(name: register, page: () => const RegisterPage()),
    GetPage(name: declareDamage, page: () => const DeclareDamagePage()),
    GetPage(name: overview, page: () => const OverviewPage()),
    GetPage(name: changePlan, page: () => const ChangePlanPage())
  ];
}
