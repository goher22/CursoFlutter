import 'package:flutter/material.dart';
import 'package:fromvalidation/src/blocs/login_bloc.dart';
export 'package:fromvalidation/src/blocs/login_bloc.dart';

class Provider extends InheritedWidget {
  static Provider? _instancia;
  factory Provider({Key? key, required Widget child}) {
    if (_instancia == null) {
      _instancia = Provider._internal(key: key, child: child);
    }

    return _instancia!;
  }

  Provider._internal({Key? key, required Widget child})
      : super(key: key, child: child);

  final loginBlog = LoginBlog();

  //Provider({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBlog of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBlog;
  }
}
