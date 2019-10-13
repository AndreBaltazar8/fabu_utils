class Ioc {
  final _registeredTypes = Map<Type, _IocDef>();
  final _instances = Map<Type, dynamic>();

  static Ioc _instance;

  Ioc._();
  factory Ioc() => _instance ?? (_instance = Ioc._());
  Ioc.create();

  T get<T>() {
    var type = T;
    var def = _registeredTypes[type];
    if (def == null) {
      _assertOrThrow("Can\'t get type ${type.toString()}: type was not registered");
    }

    if (!def.single)
      return def.construct();

    return _instances[type] ?? (_instances[type] = def.construct());
  }

  void register<T>(T Function() construct) {
    _tryRegister<T>(() => _IocDef(construct));
  }

  void registerSingle<T>(T Function() construct, {bool lazy = true}) {
    _tryRegister<T>(() {
      if (!lazy)
        _instances[T] = construct();
      return _IocDef(construct, lazy: lazy, single: true);
    });
  }

  void _tryRegister<T>(_IocDef Function() iocConst) {
    var def = _registeredTypes[T];
    if (def == null)
      _registeredTypes[T] = iocConst();
    else {
      _assertOrThrow("Type ${T.toString()} already registered");
    }
  }

  void _assertOrThrow(String message) {
    assert(false, message);
    throw IocException(message);
  }
}

class IocException implements Exception {
  final String message;

  IocException(this.message);

  @override
  String toString() {
    if (message == null) return "IocException";
    return "IocException: $message";
  }
}

class _IocDef<T> {
  T Function() construct;
  bool lazy;
  bool single;

  _IocDef(this.construct, {this.lazy = true, this.single = false});
}
