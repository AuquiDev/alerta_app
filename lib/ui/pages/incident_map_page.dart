import 'package:alerta_app/models/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IncidetMapPage extends StatefulWidget {
  List<IncidentModel> incidentList;

  IncidetMapPage({required this.incidentList});
  @override
  State<IncidetMapPage> createState() => _IncidetMapPageState();
}

class _IncidetMapPageState extends State<IncidetMapPage> {
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    getMarker();
  }

  getMarker() {
    for (var item in widget.incidentList) {
      Marker marker = Marker(
          markerId: MarkerId(_markers.length.toString()),
          position: LatLng(item.latitud, item.longitud));
      _markers.add(marker);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.incidentList);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-11.261080, -76.331244),
              zoom: 6.5,
            ),
            markers: _markers,
            onTap: (LatLng position) {
              Marker myMarker = Marker(
                  markerId: MarkerId(_markers.length.toString()),
                  position: position,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange));
              _markers.add(myMarker);
              setState(() {});
            },
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(right: 55),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: widget.incidentList
                      .map((e) => Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(135, 255, 255, 255),
                                borderRadius: BorderRadius.circular(14)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(e.tipoIncidente.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Ciudadano: ${e.id},//datosCiudadano.nombres}"),
                                    Text(
                                        "Telefono: ${e.datosCiudadano.telefono}"),
                                    Text("hora: ${e.hora}"),
                                    Text("fecha: ${e.fecha}"),
                                  ],
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
