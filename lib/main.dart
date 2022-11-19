import 'package:alerta_app/prueba.dart';
import 'package:alerta_app/ui/pages/home_pages.dart';
import 'package:alerta_app/ui/pages/login_pages.dart';
import 'package:alerta_app/utils/sp_global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // runApp(
  WidgetsFlutterBinding.ensureInitialized();
  SpGlobal _prefs = SpGlobal();
  await _prefs.initSharedPreferences();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alerta App',
     // home: const name(),//LoginPages(),
      theme: ThemeData(
        textTheme: GoogleFonts.nerkoOneTextTheme()//GoogleFonts.nunitoSansTextTheme(),
      ),
      home:  PreInit(),
    );
    
  }
}
class PreInit extends StatelessWidget {
  final SpGlobal _prefs = SpGlobal();

  @override
  Widget build(BuildContext context) {
    return _prefs.token.isEmpty ? LoginPages() : HomePages();
  }
}