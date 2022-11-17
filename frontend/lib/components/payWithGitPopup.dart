import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PayWithTokens extends StatefulWidget {
  final int tokenNumber; 

  const PayWithTokens({Key? key, required this.tokenNumber}) : super(key: key);

  @override
  State<PayWithTokens> createState() => _PayWithTokensState();
}

class _PayWithTokensState extends State<PayWithTokens> {
  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed:  () {
        // call sb function changePlanWithoutToken
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed:  () {
        // Tcall sb function changePlanWithToken
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Use GIT token for plan change"),
      content: Text("Would you like to use ${widget.tokenNumber} GIT tokens for the plan upgrade?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return alert;
  }
}