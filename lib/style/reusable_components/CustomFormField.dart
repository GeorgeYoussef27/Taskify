import 'package:flutter/material.dart';
typedef ValidatorType = String? Function(String?)?;
class CustomFormField extends StatefulWidget {
  String label;
  TextInputType keyboard;
  bool isPassword;
  ValidatorType validate;
  TextEditingController controller;
  int? maxLength;
  CustomFormField(
      {required this.label, required this.keyboard, this.isPassword = false,required this.validate,required this.controller,this.maxLength});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      validator: widget.validate,
      keyboardType: widget.keyboard,
      obscureText: widget.isPassword==true
          ?isObscured
          :false,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 18,
          ),
      decoration: InputDecoration(
        counterText: "",
          suffixIcon: widget.isPassword
              ? IconButton(
              onPressed: (){
                setState(() {
                  isObscured = !isObscured;
                });
              },
              icon: Icon(
            isObscured
                ?Icons.visibility_off_outlined
                :Icons.visibility_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ))
              : null,
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.labelSmall),
    );
  }
}
