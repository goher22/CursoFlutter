import 'package:flutter/material.dart';
import 'package:fromvalidation/src/model/producto_model.dart';
import 'package:fromvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  final productosProvider = ProductosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _crearListado(),
      floatingActionButton: _craerBoton(context),
    );
  }

  _craerBoton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarproductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos!.length,
            itemBuilder: (context, i) => _crearItem(productos[i], context),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(ProductoModel producto, BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        productosProvider.borrarProducto(producto.id.toString());
      },
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text(producto.id.toString()),
        onTap: () =>
            Navigator.pushNamed(context, 'producto', arguments: producto),
      ),
    );
  }
}
