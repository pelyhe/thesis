import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formula/general/themes.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppTextField<T> extends StatefulWidget {
  late FormControl<T> control;
  late String hint;
  late TextInputAction textInputAction;

  AppTextField({
    Key? key,
    required this.control,
    required this.hint,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  State<AppTextField<T>> createState() => _AppTextFieldState<T>();
}

class _AppTextFieldState<T> extends State<AppTextField<T>> {
  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<T>(
      formControl: widget.control,
      validationMessages: {
        'number': (control) => 'Please type a valid price',
        'required': (control) => 'Please fill out this field!',
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8.0),
        hintText: widget.hint,
        border: const UnderlineInputBorder(),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: AppColors.orange)),
      ),
      enableSuggestions: true,
      autocorrect: true,
      textInputAction: widget.textInputAction,
    );
  }
}
