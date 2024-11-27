import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  String dialogLabel;
  Color? dialogColor;
  String positiveBtnTitle;
  void Function() positiveBtnPress;
  String? negativeBtnTitle;
  void Function()? negativeBtnPress;
  CustomAlertDialog({
    required this.dialogLabel,
    required this.positiveBtnPress,
    this.positiveBtnTitle = "Ok",
    this.negativeBtnTitle,
    this.negativeBtnPress,
    this.dialogColor,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
          dialogLabel,
        style: TextStyle(
          color: dialogColor
        ),
      ),
      actions: [
        TextButton(onPressed: positiveBtnPress,
          child: Text(
           positiveBtnTitle,
          ),
        ),
        if(negativeBtnTitle!=null)
          TextButton(
            onPressed:  negativeBtnPress,
            child: Text(
              negativeBtnTitle!,
            ),
          ),
      ],
    );
  }
}
