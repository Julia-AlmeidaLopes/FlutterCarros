import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool pwd;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  AppText(
    this.label, 
    this.hint, {
    this.pwd = false, 
    this.controller,
    this.validator, 
    this.keyboardType, 
    this.textInputAction, 
    this.focusNode, 
    this.nextFocus
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: pwd,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text){
        if(nextFocus != null){
          FocusScope.of(context).requestFocus(nextFocus);
        }
        
      },
           style: TextStyle(
             fontSize:19,
             color: Colors.black
           ),
           decoration: InputDecoration(
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(22),
             ),
             labelText: label,
             labelStyle: TextStyle(
               fontSize: 20,
               color: Colors.black
             ),
             hintText: hint,
             hintStyle: TextStyle(
               fontSize:14,
               color: Colors.black
             )
           )
         );
  }
}