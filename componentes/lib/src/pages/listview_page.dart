import 'package:flutter/material.dart';
import 'dart:async';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  ScrollController _scrollController = ScrollController();

  List<int> _listanumero = [];
  int _ultimoitem = 0;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _agregar10();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //_agregar10();
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista')),
      body: Stack(
        children: <Widget>[_crearLista(), _crearLoading()],
      ),
    );
  }

  Widget _crearLista() {
    return RefreshIndicator(
      onRefresh: _obtenerPagina1,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _listanumero.length,
        itemBuilder: (BuildContext context, int index) {
          final imagen = _listanumero[index];
          return FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image:
                  NetworkImage('https://picsum.photos/500/300/?iamge=$imagen'));
        },
      ),
    );
  }

  Future<void> _obtenerPagina1() async {
    final duration = Duration(seconds: 2);
    Timer(duration, () {
      _listanumero.clear();
      _ultimoitem++;
      _agregar10();
    });

    return Future.delayed(duration);
  }

  void _agregar10() {
    setState(() {
      for (var i = 1; i < 10; i++) {
        _ultimoitem++;
        _listanumero.add(_ultimoitem);
      }
    });
  }

  Future fetchData() async {
    setState(() {
      _isloading = true;
    });
    final duration = Duration(seconds: 2);
    return Timer(duration, _respuestaHTTP);
  }

  void _respuestaHTTP() {
    _isloading = false;

    _scrollController.animateTo(_scrollController.position.pixels + 100,
        duration: Duration(milliseconds: 250),
        curve: Curves.fastLinearToSlowEaseIn);

    _agregar10();
  }

  Widget _crearLoading() {
    if (_isloading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(
            height: 25.0,
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
