import 'package:walletconnect_dart/walletconnect_dart.dart';

// source: https://github.com/RootSoft/walletconnect-dart-sdk/blob/master/example/mobile/lib/transaction_tester.dart
abstract class TransactionTester {
    TransactionTester({required this.connector});
  
    final WalletConnect connector;
  
    Future<String> signTransaction(SessionStatus session);
  
    Future<String> signTransactions(SessionStatus session);
  
    Future<SessionStatus> connect({OnDisplayUriCallback? onDisplayUri});
  
    Future<void> disconnect();
  }