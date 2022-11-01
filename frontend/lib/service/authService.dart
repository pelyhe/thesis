import 'package:get/get.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class AuthenticationService extends GetxController {
  static AuthenticationService get instance => Get.find();

  SessionStatus? session;
  String? account;


}
