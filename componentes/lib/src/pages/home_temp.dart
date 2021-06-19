
import 'package:flutter/material.dart';

class HomePageTemP extends StatelessWidget {

  final opciones = ['Uno', 'Dos', 'Tres', 'Cuatro'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes Tep')
      ),
      body: ListView(
        //children: _crearItems()
        children: _crearItemsCorta()
      ),
    );
  }

  /*List<Widget> _crearItems(){

    List<Widget> lista = [];

    for (var opt in opciones){
      lista..add(
        ListTile(
          title: Text(opt),
        )
      )..add(Divider());
    }

    return lista;
  }*/

  List<Widget> _crearItemsCorta(){

    var wifgets = opciones.map((item) { 
      return  Column(
        children: [
          ListTile(
            title: Text(item),
            subtitle: Text('Subtitle'),
            leading: Icon(Icons.access_alarms_sharp),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){ },
          ),
          Divider()
        ],
      );
    }).toList();

    return wifgets;
  }

}
