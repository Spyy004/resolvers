import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
    Key key,
    @required this.width,
    this.height,
    this.controller,
    this.title
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    //  var height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        // height: 10,
        height: 85,
        width: 0.3*width,
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
              return '$title is empty';
            }
            return null;
          },
        ),
      ),
    );
  }
}