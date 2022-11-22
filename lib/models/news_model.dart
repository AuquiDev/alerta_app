// To parse this JSON data, do
//
//     final newModel = newModelFromJson(jsonString);

import 'dart:convert';

NewModel newModelFromJson(String str) => NewModel.fromJson(json.decode(str));

String newModelToJson(NewModel data) => json.encode(data.toJson());

class NewModel {
    NewModel({
        this.id,
      required  this.link,
      required  this.titulo,
      required  this.fecha,
      required  this.imagen,
    });

    int? id;
    String link;
    String titulo;
    DateTime fecha;
    String imagen;

    factory NewModel.fromJson(Map<String, dynamic> json) => NewModel(
        id: json["id"],
        link: json["link"] ?? "http://via.placeholder.com/200x150",
        titulo: json["titulo"],
        fecha: DateTime.parse(json["fecha"]),
        imagen: json["imagen"] ?? "https://cdn.pixabay.com/photo/2012/04/26/22/31/fabric-43354__480.jpg",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "titulo": titulo,
        "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "imagen": imagen,
    };
}
