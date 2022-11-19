import 'package:alerta_app/models/cityzen_model.dart';
import 'package:alerta_app/services/api_services.dart';
import 'package:alerta_app/ui/general/colors.dart';
import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:flutter/material.dart';

class CItyzenPage extends StatelessWidget {
  CItyzenPage({super.key});
  APiServices aPiServices = APiServices();
  @override
  Widget build(BuildContext context) {
    aPiServices.getCitixen();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Listado de ciudadanos',
                style: TextStyle(
                    color: kFontPrimaryColor.withOpacity(.8),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              divader10,
              FutureBuilder(
                future: aPiServices.getCitixen(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<CityzenModel>? listData = snapshot.data;

                    return Expanded(
                      child: ListView.separated(
                        itemCount: listData!.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.black12,
                          indent: 12,
                          endIndent: 12,
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                listData[index].fullname,
                              style: TextStyle(
                                  color: kFontPrimaryColor.withOpacity(0.8),
                                  fontSize: 15),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Direccion: ${listData[index].address}',
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 15),
                                ),
                                Text(
                                  'Telefono: ${listData[index].phone}',
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
