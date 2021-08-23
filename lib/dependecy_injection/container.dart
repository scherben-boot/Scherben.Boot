import 'package:kiwi/kiwi.dart';

import 'module.dart';

class Container {
  final KiwiContainer _container = KiwiContainer();

  void addModule(Module module) => module.registerModule(_container);
  T resolve<T>() => _container.resolve<T>();
}

final Container container = Container();
