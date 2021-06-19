import 'package:prefernciasusuarioapp/src/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._inernal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._inernal();

  SharedPreferences? _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //bool? _colorSecundario;
  //int? _genero;
  //String? _nombre;

  int get genero {
    return _prefs!.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs!.setInt('genero', value);
  }

  bool get colorSecundario {
    return _prefs!.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs!.setBool('colorSecundario', value);
  }

  String get nombreUsuario {
    return _prefs!.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs!.setString('nombreUsuario', value);
  }

  String get ultimaPagina {
    return _prefs!.getString('ultimaPagina') ?? HomePage.routeName;
  }

  set ultimaPagina(String value) {
    _prefs!.setString('ultimaPagina', value);
  }
}
