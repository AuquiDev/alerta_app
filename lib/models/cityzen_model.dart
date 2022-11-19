// To parse this JSON data, do
//
//     final cityzenModel = cityzenModelFromJson(jsonString);

import 'dart:convert';

CityzenModel cityzenModelFromJson(String str) => CityzenModel.fromJson(json.decode(str));

String cityzenModelToJson(CityzenModel data) => json.encode(data.toJson());

class CityzenModel {
    CityzenModel({
       required  this.id,
      required  this.fullname,
      required  this.phone,
       required this.address,
       required this.dni,
       required this.rate,
       required this.status,
    });

    int id;
    String fullname;
    String phone;
    String address;
    String dni;
    int rate;
    String status;

    factory CityzenModel.fromJson(Map<String, dynamic> json) => CityzenModel(
        id: json["id"],
        fullname: json["nombreCompleto"] ?? "Name",
        phone: json["telefono"],
        address: json["direccion"],
        dni: json["dni"],
        rate: json["calificacion"],
        status: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombreCompleto": fullname,
        "telefono": phone,
        "direccion": address,
        "dni": dni,
        "calificacion": rate,
        "estado": status,
    };
}
