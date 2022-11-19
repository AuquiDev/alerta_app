import 'package:alerta_app/models/incident_model.dart';
import 'package:alerta_app/models/incident_register_models.dart';
import 'package:alerta_app/models/incident_type_model.dart';
import 'package:alerta_app/services/api_services.dart';
import 'package:alerta_app/ui/general/colors.dart';
import 'package:alerta_app/ui/widgets/button_custom_widget.dart';
import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RegisterIncidentModal extends StatefulWidget {
  RegisterIncidentModal({required this.incidentTypeList});

  List<IncidentTypeModel> incidentTypeList;

  @override
  State<RegisterIncidentModal> createState() => _RegisterIncidentModalState();
}

class _RegisterIncidentModalState extends State<RegisterIncidentModal> {
  int incidentValue = 0;
  Position? position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    incidentValue = widget.incidentTypeList.first.id;
    getDataPosition();
  }

    getDataPosition() async {
       //Permisos de geolocalizacion IOS 
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition();
    print(position!.latitude);
    print(position!.longitude);
  }
  @override
  Widget build(BuildContext context) {
    print(widget.incidentTypeList);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Registrar Incidente',
            style: TextStyle(
              fontSize: 18,
              color: kFontPrimaryColor.withOpacity(.8),
              fontWeight: FontWeight.bold,
            ),
          ),
          divader10,
          Text(
              'Por favor selecciona un incidente para ser enviado a la central.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: kFontPrimaryColor.withOpacity(.6),
                fontWeight: FontWeight.bold,
              )),
          divader14,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    width: 1.2, color: kFontPrimaryColor.withOpacity(.12))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  borderRadius: BorderRadius.circular(14),
                  elevation: 6,
                  value: incidentValue,
                  isExpanded: true,
                  items: widget.incidentTypeList
                      .map((e) =>
                          DropdownMenuItem(value: e.id, child: Text(e.title)))
                      .toList(),
                  onChanged: (int? value) {
                    incidentValue = value!;
                    setState(() {});
                  }),
            ),
          ),
          divader14,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ButtonCustomWidget(
              text: "Registrar Incidente",
              onTap: () async {
                APiServices apiService = APiServices();
                IncidentRegisterModel model = IncidentRegisterModel(
                    latitude:-10.064349,// position!.latitude,//-10.064349,
                    longitude:-76.248961, //position!.longitude,// -76.248961 
                    incidentTypeId: incidentValue,
                    status: "Abierto");
                bool res = await apiService.registerIncident(model);
                if (res) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
