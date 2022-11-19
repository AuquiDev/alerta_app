import 'package:alerta_app/ui/general/colors.dart';
import 'package:alerta_app/ui/pages/cityzen_pages.dart';
import 'package:alerta_app/ui/pages/incident_page.dart';
import 'package:alerta_app/ui/pages/incident_type_page.dart';
import 'package:alerta_app/ui/pages/news_page.dart';
import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:alerta_app/ui/widgets/item_menuWidget.dart';
import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bienvenido Eduardo',
                style: TextStyle(
                    color: kFontPrimaryColor.withOpacity(.8),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
            divader10,
            Text(
              'Voluptate voluptate et elit eiusmod cupidatat eu dolore quis et exercitation exercitation.',
              style: TextStyle(
                  color: kFontPrimaryColor.withOpacity(.65),
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
            divader14,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  ItemMenuWidgets(
                    color: const Color(0xfff72585),
                    icon: Icons.people, 
                    text: 'Ciudadanos',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CItyzenPage()));
                    },
                    ),       
                  ItemMenuWidgets(
                    color: Color.fromARGB(255, 247, 111, 37),
                    icon: Icons.add_alert, 
                    text: 'Incidentes',
                     onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> IncidentPage()));
                    },
                    ), 
                   ItemMenuWidgets(
                    color: Color.fromARGB(255, 37, 247, 244),
                    icon: Icons.newspaper, 
                    text: 'Noticias',
                     onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> NewPage()));
                    },
                    ), 
                   ItemMenuWidgets(
                    color: Color.fromARGB(255, 37, 247, 79),
                    icon: Icons.bar_chart, 
                    text: 'Reportes',
                     onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CItyzenPage()));
                    },
                    ), 
                    ItemMenuWidgets(
                    color: Color.fromARGB(255, 218, 69, 166),
                    icon: Icons.warning_sharp, 
                    text: 'Tipos Incidentes',
                     onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> IncidentsTypePage()));
                    },
                    ), 

                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
