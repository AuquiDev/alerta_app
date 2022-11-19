import 'package:alerta_app/models/incident_type_model.dart';
import 'package:alerta_app/services/api_services.dart';
import 'package:alerta_app/ui/general/colors.dart';
import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:flutter/material.dart';

class IncidentsTypePage extends StatelessWidget {
   IncidentsTypePage({super.key});

  APiServices apiservices = APiServices();

  @override
  Widget build(BuildContext context) {
    apiservices.getIncidentType();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Listado de tipos incidentes',
                style: TextStyle(
                    color: kFontPrimaryColor.withOpacity(.8),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              divader10,
              FutureBuilder(
                future: apiservices.getIncidentType(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<IncidentTypeModel>? listDatas = snapshot.data;

                    return Expanded(
                      child: ListView.separated(
                        itemCount: listDatas!.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.black12,
                          indent: 12,
                          endIndent: 12,
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                listDatas[index].title,
                              style: TextStyle(
                                  color: kFontPrimaryColor.withOpacity(0.8),
                                  fontSize: 15),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Area: ${listDatas[index].area}',
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 15),
                                ),
                                Text(
                                  'Nivel: ${listDatas[index].level}',
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}