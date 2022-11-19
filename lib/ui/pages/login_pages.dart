import 'package:alerta_app/models/user_models.dart';
import 'package:alerta_app/services/api_services.dart';
import 'package:alerta_app/ui/general/colors.dart';
import 'package:alerta_app/ui/pages/home_pages.dart';
import 'package:alerta_app/ui/widgets/button_custom_widget.dart';
import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:alerta_app/ui/widgets/textfield_widgets.dart';
import 'package:alerta_app/utils/assets_data.dart';
import 'package:alerta_app/utils/constanst.dart';
import 'package:flutter/material.dart';

class LoginPages extends StatefulWidget {
  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final TextEditingController _dniController = TextEditingController();

  final TextEditingController _paswodController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future _login(context) async {
    if (_formKey.currentState!.validate()) {
      APiServices aPiServices = APiServices();
      String _dni = _dniController.text;
      String _password = _paswodController.text;
      isLoading = true;
      setState(() {});
      Usermodels? usermodels = await aPiServices.login(_dni, _password);

      if (usermodels != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePages()),
            (route) => false);
        // Navigator.push(context, MaterialPageRoute(builder: ((context) => HomePages())));
      } else {
        isLoading = false;

        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: Colors.redAccent.withOpacity(.7),
            content: Row(
              children: [
                const Icon(
                  (Icons.error_outline),
                  color: Colors.white,
                ),
                divaderwitdh12,
                const Text('Hubo un error intente nuevamnete'),
              ],
            )));
      }
      print(usermodels);
    }
  } 

//f192cea511f6c6231ebbee22bcec8873ac60e497
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? SingleChildScrollView(
              child: SafeArea(
                  child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    divader40,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetData.logo,
                          height: 20,
                        ),
                        divaderwitdh6,
                        Text(
                          'Alerta APP',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: kFontPrimaryColor,
                              letterSpacing: 0.2),
                        ),
                      ],
                    ),
                    divader30,
                    Text(
                      'Aliqua eu veniam ipsum qui nostrud commodo.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: kFontPrimaryColor.withOpacity(.66),
                          letterSpacing: 0.2),
                    ),
                    divader40,
                    TexfielCustomWidgets(
                      controller: _dniController,
                      label: "Tu numero de DNI",
                      hintText: "Ingresa tu numero DNI",
                      inputTypeEnum: InputTypeEnum.dni,
                    ),
                    divader40,
                    TextFieldCustomPasswordWidget(
                      controller: _paswodController,
                    ),
                    divader30,
                   ButtonCustomWidget(
                    onTap: (){
                      _login(context);
                    }, 
                   text: 'Iniciar Sesion'),
                    divader30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Aun no estas registrado?',
                          style: TextStyle(
                              color: Colors.black.withOpacity(.4),
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                        divaderwitdh6,
                        Text(
                          'Registrate',
                          style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )))
          : const Center(
              child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.3)),
            ),
    );
  }
}
