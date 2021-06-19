import 'package:flutter/material.dart';

import 'package:prefernciasusuarioapp/src/pages/home_page.dart';
import 'package:prefernciasusuarioapp/src/pages/setting_page.dart';
import 'package:prefernciasusuarioapp/src/share_prefs/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefes = new PreferenciasUsuario();
  await prefes.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefes = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferencias',
      initialRoute: prefes.ultimaPagina,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        SettingPage.routeName: (BuildContext context) => SettingPage(),
      },
    );
  }
}
