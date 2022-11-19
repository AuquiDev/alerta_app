import 'dart:io';

import 'package:alerta_app/models/news_model.dart';
import 'package:alerta_app/services/api_services.dart';
import 'package:alerta_app/ui/pages/modals/register_incident_modal.dart';
import 'package:alerta_app/ui/pages/news_page.dart';
import 'package:alerta_app/ui/widgets/button_custom_widget.dart';
import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:alerta_app/ui/widgets/textfield_widgets.dart';
import 'package:alerta_app/utils/constanst.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewRegisterPages extends StatefulWidget {
  @override
  State<NewRegisterPages> createState() => _NewRegisterPagesState();
}

class _NewRegisterPagesState extends State<NewRegisterPages> {
  final TextEditingController _titlecontroller = TextEditingController();

  final TextEditingController _linkController = TextEditingController();

  XFile? _imageFile;

  final ImagePicker _imagePicker = ImagePicker();

  getImageCamera() async {
    _imageFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (_imageFile != null) {
      setState(() {});
    }
  }

  getImageGellery() async {
    _imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (_imageFile != null) {
      setState(() {});
    }
  }

  registerNEws() async {
    APiServices aPiServices = APiServices();
    NewModel model = NewModel(
        link: _linkController.text,
        titulo: _titlecontroller.text,
        fecha: DateTime.now(),
        imagen: _imageFile!.path);
    // aPiServices.registerNews(File(_imageFile!.path));
    aPiServices.registerNews(model);
  }

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro Noticias',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TexfielCustomWidgets(
                  controller: _titlecontroller,
                  label: "titulo: ",
                  hintText: 'Ingresa un titulo',
                  inputTypeEnum: InputTypeEnum.text,
                ),
                divader14,
                TexfielCustomWidgets(
                  controller: _linkController,
                  label: "URL VIdeo: ",
                  hintText: 'Ingresa link video',
                  inputTypeEnum: InputTypeEnum.text,
                ),
                divader14,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          getImageCamera();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 47, 136, 151),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Camara')),
                    divaderwitdh3,
                    ElevatedButton.icon(
                        onPressed: () {
                          getImageGellery();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 175, 54, 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        icon: const Icon(Icons.image),
                        label: const Text('Geleria')),
                  ],
                ),
                divader14,
                _imageFile != null
                    ? Container(
                        height: 200,
                        width: 200,
                        decoration: _decoration(Colors.white),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                            image: FileImage(File(_imageFile!.path)),
                          ),
                        ),
                      )
                    : Container(
                        height: 200,
                        width: 200,
                        decoration: _decoration(Colors.white),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: const Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Image(
                              image: AssetImage('assets/images/image.jpeg'),
                            ),
                          ),
                        ),
                      ),
                divader20,
                ButtonCustomWidget(
                  text: "Registrar noticia",
                  onTap: () {
                   registerNEws();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _decoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.25),
              offset: const Offset(1, 5),
              blurRadius: 6)
        ]);
  }
}
