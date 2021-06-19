import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorslider = 100.0;
  bool _bloquearcheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            _crearSlider(),
            _crearCheckBox(),
            _crearSwitch(),
            Expanded(child: _crearImagen())
          ],
        ),
      ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      value: _valorslider,
      activeColor: Colors.indigoAccent,
      label: 'tamaño de la imagen',
      min: 10.0,
      max: 400.0,
      onChanged: (_bloquearcheck)
          ? null
          : (valor) {
              setState(() {
                _valorslider = valor;
              });
            },
    );
  }

  Widget _crearImagen() {
    return Image(
        image: NetworkImage(
            'https://recallin2hp.files.wordpress.com/2013/05/tumblr_mlspxlkjqd1qh1x6ko1_500.png'),
        width: _valorslider,
        fit: BoxFit.contain);
  }

  Widget _crearCheckBox() {
    // return Checkbox(
    //     value: _bloquearcheck,
    //     onChanged: (valor) {
    //       setState(() {
    //         _bloquearcheck = valor!;
    //       });
    //     });
    return CheckboxListTile(
        title: Text('Bloquear el Slider'),
        value: _bloquearcheck,
        onChanged: (valor) {
          setState(() {
            _bloquearcheck = valor!;
          });
        });
  }

  Widget _crearSwitch() {
    return SwitchListTile(
        title: Text('Bloquear el Slider'),
        value: _bloquearcheck,
        onChanged: (valor) {
          setState(() {
            _bloquearcheck = valor;
          });
        });
  }
}
