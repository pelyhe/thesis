import 'package:flutter/material.dart';
import 'package:formula/general/themes.dart';

// ignore: must_be_immutable
class AppButton extends StatefulWidget {
  //text, icon, min, max size, onPressed
  String text;
  Icon icon;
  Size min, max;
  Function() onPressed;

  AppButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.min,
      required this.max,
      required this.onPressed})
      : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        side: MaterialStateProperty.all(BorderSide(
            color: AppColors.navigationColor,
            width: 1.5,
            style: BorderStyle.solid)),
        minimumSize: MaterialStateProperty.all<Size>(widget.min),
        maximumSize: MaterialStateProperty.all<Size>(widget.max),
      ),
      child: Row(
        children: [
          widget.icon,
          const SizedBox(width: 8),
          Text(
            widget.text,
            style: TextStyle(color: AppColors.navigationColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
