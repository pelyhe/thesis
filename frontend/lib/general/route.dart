import 'package:formula/pages/change_plan.dart';
import 'package:formula/pages/connect_wallet.dart';
import 'package:formula/pages/declare_damage.dart';
import 'package:formula/pages/judge_reports.dart';
import 'package:formula/pages/loading.dart';
import 'package:formula/pages/overview.dart';
import 'package:formula/pages/register.dart';
import 'package:formula/pages/splash.dart';
import 'package:get/get.dart';

class AppRoutes {
  static String connectWallet = "/connect";
  static String register = "/register";
  static String declareDamage = "/declare-damage";
  static String overview = "/overview";
  static String changePlan = "/change-plan";
  static String loading = "/loading";
  static String splash = "/splash";
  static String judgeReports = "/judge";

  static final pages = [
    GetPage(name: connectWallet, page: () => const ConnectWalletPage()),
    GetPage(name: register, page: () => const RegisterPage()),
    GetPage(name: declareDamage, page: () => const DeclareDamagePage()),
    GetPage(name: overview, page: () => const OverviewPage()),
    GetPage(name: changePlan, page: () => const ChangePlanPage()),
    GetPage(name: loading, page: () => const LoadingPage()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: judgeReports, page: () => const JudgeReportsPage()),
  ];
}
