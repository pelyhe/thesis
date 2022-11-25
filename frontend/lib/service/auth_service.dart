import 'package:dart_web3/credentials.dart';
import 'package:formula/config/GasInsurance.g.dart';
import 'package:get/get.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class AuthenticationService extends GetxController {
  static AuthenticationService get instance => Get.find();

  SessionStatus? session;
  EthereumAddress? account;
  Credentials? credentials;
  GasInsurance? contract;
}
