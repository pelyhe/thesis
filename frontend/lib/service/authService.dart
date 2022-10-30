import 'package:get/get.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthenticationService extends GetxController {
  static AuthenticationService get instance => Get.find();
  
  bool isWalletConnected = false;
  SessionStatus? _session;
  String? _uri;

  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'Gas heating insurance',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ])
  );

  Future<void> connectWallet() async {
    if (!connector.connected) {
      try {
        _session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);

        });
      } catch (exp) {
        print(exp);
      }
    }
  }
}
