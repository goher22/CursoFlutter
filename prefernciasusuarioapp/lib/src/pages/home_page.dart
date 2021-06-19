import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prefernciasusuarioapp/src/share_prefs/preferencias_usuario.dart';
import 'package:prefernciasusuarioapp/src/widgets/menu_widgets.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  final prefet = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefet.ultimaPagina = HomePage.routeName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias de Usuario'),
        backgroundColor: (prefet.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWigets(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Color Secundario: ${prefet.colorSecundario}'),
          Divider(),
          Text('Genero: ${prefet.genero}'),
          Divider(),
          Text('Nombre de Usuario: ${prefet.nombreUsuario}'),
          Divider(),
        ],
      ),
    );
  }
}
