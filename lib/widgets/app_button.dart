import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  Function onPressed;
  bool showProgress;

  AppButton(this.text, {this.onPressed, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
     return Container(
           height: 44,
           child: RaisedButton(
             shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.yellow,
            child: showProgress ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
              ),
            ) 
           : Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19
              ),
            ),
              onPressed: onPressed,
           ),
         );
      
    
  }
}