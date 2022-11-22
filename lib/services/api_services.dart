import 'dart:convert';
import 'dart:io';

import 'package:alerta_app/models/cityzen_model.dart';
import 'package:alerta_app/models/incident_register_models.dart';
import 'package:alerta_app/models/incident_type_model.dart';
import 'package:alerta_app/models/news_model.dart';
import 'package:alerta_app/models/user_models.dart';
import 'package:alerta_app/utils/constanst.dart';
import 'package:alerta_app/utils/sp_global.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import '../models/incident_model.dart';

class APiServices {

   SpGlobal _prefs = SpGlobal();

  Future<Usermodels?> login(String dni, String password) async {
    Uri _url = Uri.parse('$pathProduction/login/');
    http.Response response = await http.post(_url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": dni, //"47707721",
          "password": password, //"mandarina",
        }));
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      Usermodels usermodels = Usermodels.fromJson(myMap['user']);

      _prefs.token = myMap["access"];// token 

      print(usermodels);
      return usermodels;
    }
    return null;
    // print(response.statusCode);
    // print(response.body);
  }

  Future<List<CityzenModel>> getCitixen() async {
    Uri _url = Uri.parse("$pathProduction/ciudadanos/");
    http.Response response = await http.get(_url);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List list = myMap['data'];
      print(list);
      List<CityzenModel> cityzenList =
          list.map(((e) => CityzenModel.fromJson(e))).toList();
      print(cityzenList);
      return cityzenList;
    }
    return [];
  }

  Future<List<IncidentTypeModel>> getIncidentType() async {
    Uri _url = Uri.parse("$pathProduction/incidentes/tipos/");
    http.Response response = await http.get(_url);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      List<IncidentTypeModel> inicidentTypeList =
          list.map((e) => IncidentTypeModel.fromJson(e)).toList();
      return inicidentTypeList;
    }
    return [];
  }

  Future getIncident() async {
    Uri _url = Uri.parse("$pathProduction/incidentes/");
    http.Response response = await http.get(_url);
    print(response.statusCode);
    print(response.body); //es un string
    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      List<IncidentModel> incidentList =
          list.map((e) => IncidentModel.fromJson(e)).toList();
      return incidentList;
    }
    return [];
  }


  Future<bool> registerIncident(IncidentRegisterModel model) async {
    Uri _url = Uri.parse("$pathProduction/incidentes/crear/");
    http.Response response = await http.post(
      _url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token ${_prefs.token}",
       // "Authorization": "Token 316e59daba478839256635410574edfc4786216a",
      },
      body: json.encode(
        {
          "latitud": model.latitude,
          "longitud": model.longitude,
          "tipoIncidente": model.incidentTypeId,
          "estado": model.status
        },
      ),
    );
    // if(response.statusCode == 201){
    //   return true;
    // }
    // return false;
    return response.statusCode == 201;
  }

   Future<NewModel?> registerNews(NewModel models)async{
    Uri _url = Uri.parse("$pathProduction/noticias/");

    List<String> mimeType =  mime(models.imagen)!.split("/");//split convierte y corta los lemento y lo convierte en una lista

    http.MultipartRequest request =  http.MultipartRequest("POST",_url);
   // print(mime(imageFile.path));

    http.MultipartFile file = await http.MultipartFile.fromPath(
      "imagen", models.imagen,
       contentType: MediaType(mimeType[0], mimeType[1])
      );


    request.fields["titulo"] = models.titulo;
    request.fields["link"] = models.link;
    request.fields["fecha"] = "2022-11-16";

    request.files.add(file);
    
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await  http.Response.fromStream(streamedResponse);
    print('HOLAAAAAA');
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 201){
      Map<String,dynamic> myMap = json.decode(response.body);
      NewModel newsModel = NewModel.fromJson(myMap);
      return newsModel;
    }
    return null;
  }

  Future getNews() async {
    Uri _url = Uri.parse("$pathProduction/noticias/");
    http.Response response = await http.get(_url);
    print(response.statusCode);
    print(response.body); //es un string
    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      List<NewModel> incidentList =
          list.map((e) => NewModel.fromJson(e)).toList();
          
      return incidentList;
    }
   
   
    return [];
  }
}
