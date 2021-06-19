import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  
  final estilotexto = TextStyle(fontSize: 30.0);

  int conteo = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Numeros de clicks', style: estilotexto),
            Text('$conteo', style: estilotexto)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('Hola mundo');
          conteo++;
        },
      ),
    );
  }
}