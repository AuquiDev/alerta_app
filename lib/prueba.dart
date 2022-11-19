import 'package:alerta_app/ui/pages/login_pages.dart';
import 'package:flutter/material.dart';
class name extends StatelessWidget {
  const name({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: IconButton(icon: const Icon(Icons.abc_sharp),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context)=> LoginPages())),),
        ),
      ),
    );
  }
}