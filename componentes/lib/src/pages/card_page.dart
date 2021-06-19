import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cards'),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () => Navigator.pop(context),
      ),
      body: ListView(
        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        padding: EdgeInsets.all(10),
        children: <Widget>[
          _cardTipe1(),
          SizedBox(height: 30),
          _cardTipe2(),
          SizedBox(height: 30),
          _cardTipe1(),
          SizedBox(height: 30),
          _cardTipe2(),
          SizedBox(height: 30),
          _cardTipe1(),
          SizedBox(height: 30),
          _cardTipe2(),
          SizedBox(height: 30),
          _cardTipe1(),
          SizedBox(height: 30),
          _cardTipe2(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _cardTipe1() {

    return Card(
      elevation:1.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue),
            title: Text('Soy el titulo de esta tarjeta'),
            subtitle: Text('Aqui necesiotro probar esto por eso estoy escribiendo pendejadas para poder probar esto'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {}
              ),
              TextButton(
                child: Text('Ok'),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );

  }

  Widget _cardTipe2() {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage('https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80'),
            fadeInDuration: Duration( milliseconds: 200 ),
            height: 300,
            fit: BoxFit.cover,
          ),
          //Image(image: NetworkImage('https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80')),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('No respeta los bordes')
          )
        ],
      ),
    );
  }
}