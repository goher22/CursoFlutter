import 'package:flutter/material.dart';
import 'package:fromvalidation/src/blocs/productos_bloc.dart';
import 'package:fromvalidation/src/blocs/provider.dart';
import 'package:fromvalidation/src/model/producto_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productoBloc = Provider.productosBloc(context);
    productoBloc.cargarProductos();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _crearListado(productoBloc),
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

  Widget _crearListado(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStrem,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos!.length,
            itemBuilder: (context, i) =>
                _crearItem(productos[i], productosBloc, context),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(ProductoModel producto, ProductosBloc productosBloc,
      BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) =>
          productosBloc.eliminarproducto(producto.id.toString()),
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text(producto.id.toString()),
        onTap: () =>
            Navigator.pushNamed(context, 'producto', arguments: producto),
      ),
    );
  }
}
