import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';
import 'package:formula/general/utils.dart';
import 'package:formula/service/authService.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class ConnectWalletPage extends StatefulWidget {
  const ConnectWalletPage({Key? key}) : super(key: key);

  @override
  State<ConnectWalletPage> createState() => _ConnectWalletPageState();
}

class _ConnectWalletPageState extends State<ConnectWalletPage> {
  final controller = ConnectWalletController();

  @override
  Widget build(BuildContext context) {
    ScreenSize.refresh(context);
    return GetBuilder<ConnectWalletController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: scaffoldBody(
              context: context,
              mobileBody: mobileBody(),
              tabletBody: mobileBody(),
            ),
          );
        });
  }

  Widget mobileBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Connect your wallet",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 30,
                color: AppColors.navigationColor),
          ),
          const SizedBox(
            height: 100,
          ),
          Image.network(
            "https://cdn-icons-png.flaticon.com/512/5087/5087579.png",
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 100,
          ),
          SliderButton(
              action: () => controller.connectWallet(context),
              label: Text(
                "Slide to connect",
                style: TextStyle(
                    color: AppColors.navigationColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              icon: const Icon(Icons.arrow_right_alt_rounded))
        ],
      ),
    );
  }
}

class ConnectWalletController extends GetxController {
  SessionStatus? session;
  String? account;

  Future<void> connectWallet(BuildContext context) async {
    var connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
            name: 'Gas heating insurance',
            url: 'https://walletconnect.org',
            icons: [
              'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
            ]));

    // Subscribe to events
    connector.on('connect', (session) => print(session));
    connector.on('session_update', (payload) => print(payload));
    connector.on('disconnect', (session) => print(session));

    // Create a new session
    if (!connector.connected) {
      final tmp = await connector.createSession(
          chainId: 5,
          onDisplayUri: (uri) async => {
                await launchUrlString(uri, mode: LaunchMode.externalApplication)
              });
      AuthenticationService.instance.session = tmp;
    }

    AuthenticationService.instance.account =
        AuthenticationService.instance.session!.accounts[0];
    Navigator.pushReplacementNamed(context, '/loading');

    // TODO: https://github.com/MetaMask/metamask-mobile/issues/3735
    /*if (account != null) {
      final client = Web3Client("	https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161", Client());
      EthereumWalletConnectProvider provider =
          EthereumWalletConnectProvider(connector);
      credentials = WalletConnectEthereumCredentials(provider: provider);
      yourContract = YourContract(address: contractAddr, client: client);
    }*/
  }
}
