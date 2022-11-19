import 'package:alerta_app/ui/general/colors.dart';
import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:alerta_app/utils/constanst.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TexfielCustomWidgets extends StatelessWidget {
  TexfielCustomWidgets(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.label,
      this.inputTypeEnum
      });
  TextEditingController controller;
  String label; 
  String hintText;
  InputTypeEnum? inputTypeEnum;
 

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: kFontPrimaryColor.withOpacity(.66),
              letterSpacing: 0.2),
        ),
        divader10,
        TextFormField(
          inputFormatters: inputTypeEnum == InputTypeEnum.dni ||
                  inputTypeEnum == InputTypeEnum.telefono
              ? [FilteringTextInputFormatter.allow(RegExp("[0-9]"))]
              : [],
          maxLength: inputTypeEnum == InputTypeEnum.dni ? 8 : null,
          keyboardType: inputTypeMapa[inputTypeEnum],
          controller: controller,
          decoration: InputDecoration(
            counter: SizedBox(),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: kFontPrimaryColor.withOpacity(.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: kFontPrimaryColor.withOpacity(.14), width: 0.9),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: kFontPrimaryColor.withOpacity(.14), width: 0.9),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: kFontPrimaryColor.withOpacity(.14), width: 0.9),
            ),
          ),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return "Campo Obligatorio";
            }
            if (inputTypeEnum == InputTypeEnum.dni && value!.length < 8) {
              return "Ingrese 8 digitos";
            }
            return null;
          },
        )
      ],
    );
  }
}

class TextFieldCustomPasswordWidget extends StatefulWidget {
  TextEditingController controller;
  TextFieldCustomPasswordWidget({
    required this.controller,
  });

  @override
  State<TextFieldCustomPasswordWidget> createState() =>
      _TextFieldCustomPasswordWidgetState();
}

class _TextFieldCustomPasswordWidgetState
    extends State<TextFieldCustomPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tu contraseña",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: kFontPrimaryColor.withOpacity(0.75),
          ),
        ),
        divader10,
        TextFormField(
          controller: widget.controller,
          obscureText: isInvisible,
          style: TextStyle(
            color: kFontPrimaryColor.withOpacity(0.80),
            fontSize: 14.0,
          ),
          decoration: InputDecoration(
            hintText: "Ingrese su contraseña",
            hintStyle: TextStyle(
              fontSize: 14.0,
              color: kFontPrimaryColor.withOpacity(0.5),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye_outlined,
                size: 18.0,
                color: kFontPrimaryColor.withOpacity(0.50),
              ),
              onPressed: () {
                isInvisible = !isInvisible;
                setState(() {});
              },
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: kFontPrimaryColor.withOpacity(0.12),
                width: 0.9,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: kFontPrimaryColor.withOpacity(0.12),
                width: 0.9,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: kFontPrimaryColor.withOpacity(0.12),
                width: 0.9,
              ),
            ),
          ),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return "Campo Obligatorio";
            }
            return null;
          },
        ),
      ],
    );
  }
}
