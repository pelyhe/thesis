import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResignPopup extends StatelessWidget {
  const ResignPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Resign"),
      onPressed:  () {
        // TODO: call resign
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Resign insurance"),
      content: const Text("Are you sure want to resign your gas insurance?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return alert;
  }
}