import 'dart:ffi';
import 'dart:io';

import 'package:alerta_app/models/incident_model.dart';
import 'package:alerta_app/models/incident_type_model.dart';
import 'package:alerta_app/services/api_services.dart';
import 'package:alerta_app/ui/general/colors.dart';
import 'package:alerta_app/ui/pages/incident_map_page.dart';
import 'package:alerta_app/ui/pages/modals/register_incident_modal.dart';
import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

class IncidentPage extends StatefulWidget {
  IncidentPage({super.key});

  @override
  State<IncidentPage> createState() => _IncidentPageState();
}

class _IncidentPageState extends State<IncidentPage>
    with TickerProviderStateMixin {
  APiServices aPiServices = APiServices();

  List<IncidentTypeModel> inicdentTypeList = [];
  List<IncidentModel> listData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    inicdentTypeList = await aPiServices.getIncidentType();
  }

  showAddIncidentModal(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        transitionAnimationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 600)),
        context: context,
        builder: (context) {
          return RegisterIncidentModal(
            incidentTypeList: inicdentTypeList,
          );
        }).then((value) {
      setState(() {});
    });
  }

  buildPDF() async {
    ByteData byteData = await rootBundle.load('assets/images/hoja.png');

    Uint8List imagesBytes = byteData.buffer.asUint8List();

    pw.Document pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Image(pw.MemoryImage(imagesBytes), height: 30.0),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Andean Lodges: "),
                      pw.Text("Reporte: 001"),
                      pw.Text("Fecha: "),
                      pw.Text("Codigo Grupo:"),
                    ]),
              ]),
          pw.Divider(),
          pw.ListView.builder(
              itemCount: listData.length,
              itemBuilder: ((pw.Context context, int index) {
                return pw.Container(
                    padding: pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                      width: .2,
                      color: PdfColors.black,
                    )),
                    margin: pw.EdgeInsets.all(10),
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Container(
                            margin: pw.EdgeInsets.only(right: 25),
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("Tipo Incidente: ",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text("Ciudadano: "),
                                  pw.Text("Telefono: "),
                                  pw.Text("Documento Identidad:"),
                                  pw.Text("fecha:"),
                                  pw.Text("hora:"),
                                ]),
                          ),
                            pw.Container(
                            
                            child:  pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(listData[index].tipoIncidente.title,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(listData[index].datosCiudadano.nombres),
                                pw.Text(
                                    listData[index].datosCiudadano.telefono),
                                pw.Text(listData[index].fecha),
                                pw.Text(listData[index].hora),
                              ]),
                          ),
                         
                          pw.Container(
                            margin: pw.EdgeInsets.only(left: 25),
                            child: pw.Image(pw.MemoryImage(imagesBytes),
                                height: 30.0),
                          )
                        ]));
              })),
        ];
      },
    ));
    Uint8List bytes = await pdf.save();
    Directory directory = await getApplicationDocumentsDirectory();
    File filePDF = File("${directory.path}/alerta.pdf");
    filePDF.writeAsBytes(bytes);
    OpenFilex.open(filePDF.path);
    print("RUTA ${directory.path}");
  }

  @override
  Widget build(BuildContext context) {
    aPiServices.getIncident();
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            //PDF
            onTap: (() {
              buildPDF();
            }),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 31, 106, 181),
              ),
              child: const Icon(
                Icons.picture_as_pdf_sharp,
                color: Colors.white,
              ),
            ),
          ),
          divader10,
          InkWell(
            //GOOGLE MAPS
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IncidetMapPage(
                            incidentList: listData,
                          )));
            }),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 181, 98, 31),
              ),
              child: Icon(
                Icons.gps_fixed,
                color: Colors.white,
              ),
            ),
          ),
          divader10,
          FloatingActionButton(
            onPressed: (() {
              showAddIncidentModal(context);
            }),
            backgroundColor: kBrantPrimaryColor,
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Listado de incidentes',
              style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(.8),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            divader10,
            FutureBuilder(
                future: aPiServices.getIncident(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    listData = snapshot.data;
                    return Expanded(
                      child: ListView.separated(
                        itemCount: listData.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.black12,
                          indent: 12,
                          endIndent: 12,
                        ),
                        itemBuilder: ((context, index) {
                          return ListTile(
                            title: Text(
                              '${listData[index].tipoIncidente.title}',
                              style: TextStyle(
                                  color: kFontPrimaryColor.withOpacity(0.8),
                                  fontSize: 15),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ciudadano: ${listData[index].datosCiudadano.nombres}',
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 15),
                                ),
                                Text(
                                  'Telefono: ${listData[index].datosCiudadano.telefono}',
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listData[index].hora,
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 15),
                                ),
                                Text(
                                  listData[index].fecha,
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ],
        ),
      )),
    );
  }
}
