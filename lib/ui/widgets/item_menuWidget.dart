import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';

class ItemMenuWidgets extends StatelessWidget {
  ItemMenuWidgets(
      {required this.onTap,
      required this.text,
      required this.color,
      required this.icon});
  String text;
  Color color;
  IconData icon;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  offset: const Offset(0, 4),
                  blurRadius: 12)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: kFontPrimaryColor.withOpacity(.5),
                      offset: const Offset(0, 02),
                      blurRadius: 5)
                ], color: color, shape: BoxShape.circle),
                child: Icon(
                  icon,
                  color: const Color.fromARGB(205, 255, 255, 255),
                )),
            divader6,
            Text(
              text,
              style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(.7), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
