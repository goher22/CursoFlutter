import 'package:flutter/material.dart';
import 'package:prefernciasusuarioapp/src/share_prefs/preferencias_usuario.dart';
import 'package:prefernciasusuarioapp/src/widgets/menu_widgets.dart';

class SettingPage extends StatefulWidget {
  static final String routeName = 'setting';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool? _colorSecundario;
  int? _genero;
  String _nombre = 'Carlos';

  TextEditingController? _textController;

  final preft = PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    preft.ultimaPagina = SettingPage.routeName;
    _genero = preft.genero;
    _colorSecundario = preft.colorSecundario;
    _textController = new TextEditingController(text: preft.nombreUsuario);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias de Usuario'),
        backgroundColor: (preft.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWigets(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Setting',
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSecundario!,
            title: Text('Color Secundario'),
            onChanged: (value) {
              setState(() {
                _colorSecundario = value;
                preft.colorSecundario = value;
              });
            },
          ),
          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),
          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el telefono',
              ),
              onChanged: (value) {
                preft.nombreUsuario = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  void _setSelectedRadio(int? value) async {
    preft.genero = value!;

    _genero = value;
    setState(() {});
  }
}
