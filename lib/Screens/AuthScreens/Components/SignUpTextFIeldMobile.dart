import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpTextFieldMobile extends StatelessWidget {
  const SignUpTextFieldMobile({Key key,this.width,this.height,this.title,this.controller}) : super(key: key);
  final double width;
  final double height;
  final String title;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: 10,
        height: 55,
        width: 0.7*width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffD2D8CF)),
        ),
        child: TextFormField(
            controller: controller,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return '$title  is empty';
            }
            return null;
          },
        ),
      ),
    );
  }
}