import 'package:alerta_app/ui/general/colors.dart';
import 'package:flutter/material.dart';

class ButtonCustomWidget extends StatelessWidget {
   ButtonCustomWidget({
    required this.onTap,
    required this.text
   });
   
   String text;
   Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(colors: [
              kBrantSecundaryColor.withOpacity(.8),
              kBrantPrimaryColor,
            ]),
            boxShadow: [
              //
              BoxShadow(
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  color: kBrantPrimaryColor.withOpacity(.4))
            ]),
        child:  Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
