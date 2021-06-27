import 'package:fromvalidation/src/providers/productos_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:fromvalidation/src/model/producto_model.dart';

class ProductosBloc {
  final _productosController = BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = BehaviorSubject<bool>();

  final _productosProvider = ProductosProvider();

  Stream<List<ProductoModel>> get productosStrem => _productosController.stream;
  Stream<bool> get cargar => _cargandoController.stream;

  void cargarProductos() async {
    final productos = await _productosProvider.cargarproductos();
    _productosController.sink.add(productos);
  }

  void agregarproducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  void editarproducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.editarProducto(producto);
    _cargandoController.sink.add(false);
  }

  void eliminarproducto(String id) async {
    await _productosProvider.borrarProducto(id);
  }

  dispose() {
    _productosController.close();
    _cargandoController.close();
  }
}
