import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fromvalidation/src/model/producto_model.dart';

class ProductosProvider {
  final String _url = 'flutter-varios-46609-default-rtdb.firebaseio.com';
  Future<bool> crearProducto(ProductoModel producto) async {
    try {
      final url = Uri.https(_url, 'productos.json');
      final resp = await http.post(url, body: productoModelToJson(producto));
      final decodedData = json.decode(resp.body);
      print(decodedData);
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    try {
      final url = Uri.https(_url, 'productos/${producto.id}.json');
      final resp = await http.put(url, body: productoModelToJson(producto));
      final decodedData = json.decode(resp.body);
      print(decodedData);
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<List<ProductoModel>> cargarproductos() async {
    final List<ProductoModel> productos = [];
    final url = Uri.https(_url, 'productos.json');
    final resp = await http.get(url);
    if (resp.body != "null") {
      final Map<String, dynamic> decodedData = json.decode(resp.body);
      decodedData.forEach((id, prod) {
        final prodTemp = ProductoModel.fromJson(prod);
        prodTemp.id = id;
        productos.add(prodTemp);
      });
    }
    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = Uri.https(_url, 'productos/$id.json');
    await http.delete(url);
    return 1;
  }
}
