import 'package:alerta_app/models/news_model.dart';
import 'package:alerta_app/services/api_services.dart';
import 'package:alerta_app/ui/general/colors.dart';
import 'package:alerta_app/ui/pages/new_register_pages.dart';
import 'package:alerta_app/ui/widgets/general_widget.dart';
import 'package:alerta_app/ui/widgets/textfield_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
   NewPage({super.key});

   APiServices aPiServices = APiServices();

  @override
  Widget build(BuildContext context) {

    aPiServices.getNews();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child:Icon(Icons.add),
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> NewRegisterPages()));
        },),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Listado de Noticias',
                style: TextStyle(
                    color: kFontPrimaryColor.withOpacity(.8),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              divader10,
              
              FutureBuilder(
                future: aPiServices.getNews(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<NewModel>? listData = snapshot.data;

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
                                '${listData[index].id} : ${listData[index].titulo}',
                              style: TextStyle(
                                  color: kFontPrimaryColor.withOpacity(0.8),
                                  fontSize: 15),
                              maxLines: 3,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               
                                Text(
                                  'FECHA: ${listData[index].fecha}',
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.78),
                                      fontSize: 15),
                                ),
                                 Text(
                                  'Video: ${listData[index].link}',
                                  style: TextStyle(
                                      color:
                                          kFontPrimaryColor.withOpacity(0.55),
                                      fontSize: 12),
                                ),
                              ],
                            ),

                            trailing:  Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.25),
                                    offset: Offset(0,5),
                                    blurRadius: 6
                                  )
                                ]
                              ),
                              child:   
                            //   ClipRRect(
                            //     borderRadius: BorderRadius.circular(10),
                            //     child: FadeInImage(
                            //       fit: BoxFit.fill,
                            //       image: snapshot.data != null ?   NetworkImage(listData[index].imagen.toString(),): NetworkImage('http://via.placeholder.com/200x150') ,
                            //       placeholder: AssetImage('assets/images/image.jpeg'),
                            //       ),
                            //   ) //s: Icon(Icons.bus_alert_outlined),
                            // ),
                            
                             CachedNetworkImage(
                                imageUrl: listData[index].imagen.toString(),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(listData[index].imagen.toString()),
                                        fit: BoxFit.cover,
                                        ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Image.asset('assets/images/image.jpeg'),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                          ));
                          
                        },
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }
              ),
            ],
          ),
        ),
      ),
      
      
    );
  }
}