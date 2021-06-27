import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fromvalidation/src/blocs/productos_bloc.dart';
import 'package:fromvalidation/src/blocs/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fromvalidation/src/model/producto_model.dart';
import 'package:fromvalidation/src/utilis/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductosBloc? productosBloc;
  ProductoModel producto = ProductoModel();
  bool _guardando = false;
  File? foto;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);
    final prodData = ModalRoute.of(context)?.settings.arguments;
    if (prodData != null) {
      producto = prodData as ProductoModel;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            onPressed: _seleccionarForo,
            icon: Icon(Icons.photo_size_select_actual),
          ),
          IconButton(
            onPressed: _tomarFoto,
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: this.formkey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'producto'),
      onSaved: (value) => producto.titulo = value!,
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'producto'),
      onSaved: (value) => producto.valor = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value.toString())) {
          return null;
        } else {
          return 'Solo Numeros';
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      title: Text('Disponible'),
      value: producto.disponible,
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      onPressed: (_guardando) ? null : _submit,
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  void _submit() {
    if (!formkey.currentState!.validate()) return;
    formkey.currentState!.save();
    setState(() {
      _guardando = true;
    });
    if (producto.id == null) {
      productosBloc!.agregarproducto(producto);
      // productoPorvider.crearProducto(producto);
    } else {
      productosBloc!.editarproducto(producto);
      //productoPorvider.editarProducto(producto);
    }
    setState(() {
      _guardando = false;
    });
    mostrarSnackbar('Registro Guardado');
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(mensaje),
    );
    // ignore: deprecated_member_use
    scaffoldKey.currentState!.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return Container();
    } else {
      // ignore: unnecessary_null_comparison
      if (foto != null) {
        return Image.file(
          foto!,
          height: 300.0,
          fit: BoxFit.cover,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  void _seleccionarForo() async {
    _procesarImagen(ImageSource.gallery);
  }

  void _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origin) async {
    final pickedFile = await _picker.getImage(source: origin);
    // ignore: unnecessary_null_comparison
    foto = File(pickedFile!.path);
    if (foto != null) {}
    setState(() {});
  }
}
