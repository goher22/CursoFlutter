import 'package:flutter/material.dart';
import 'package:componentes/src/providers/menu_provider.dart';
import 'package:componentes/src/utils/icono_string_util.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Component'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    //menuprovider.cargarData()

    return FutureBuilder(
      future: menuprovider.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {  
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
        
      },
      
    );
  }

  List<Widget> _listaItems( List<dynamic>? data, BuildContext context ) {

    final List<Widget> opciones = [];

    data!.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: (){
          Navigator.pushNamed(context, opt['ruta']);
          //final route = MaterialPageRoute(
            //builder: (context) => AlertPage()
          //);
          //Navigator.push(context, route);
        },
      );

      opciones..add( widgetTemp )..add( Divider() );

    });

    return opciones;

  }

}