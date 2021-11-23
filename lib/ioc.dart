/// A container for IoC instances.
///
/// Allows to register and instantiate types to used by other components.
///
/// Supports registering types that construct a new object every time they are
/// retrieved from the container (a factory) or constructing/retrieving
/// singleton objects.
class Ioc {
  final _registeredTypes = Map<Type, _IocDef>();
  final _instances = Map<Type, dynamic>();

  static Ioc? _instance;

  Ioc._();

  /// Creates or returns the instance of the default IoC container.
  ///
  /// To create new IoC containers use [Ioc.create].
  factory Ioc() => _instance ?? (_instance = Ioc._());

  /// Creates a new IoC container.
  Ioc.create();

  /// Gets a instance of type [T] that is registered in the container.
  ///
  /// This can initialize this type and return it immediately, or store it for
  /// subsequent calls for the singleton case.
  T get<T>() {
    var type = T;
    var def = _registeredTypes[type];
    if (def == null) {
      _assertOrThrow(
          "Can\'t get type ${type.toString()}: type was not registered");
    }

    if (!def!.single) return def.construct();

    return _instances[type] ?? (_instances[type] = def.construct());
  }

  /// Registers a new construct function for type [T] that will produce an
  /// object every time it is called.
  void register<T>(T Function() construct) {
    _tryRegister<T>(() => _IocDef(construct));
  }

  /// Registers a new construct function for type [T] that will be called once
  /// to create the object of the specified type.
  ///
  /// Optionally a [lazy] parameter can be specified to control the creation of
  /// this singleton object. Setting the parameter to `false`, will cause the
  /// construct to be called immediately. Defaults to `true`.
  void registerSingle<T>(T Function() construct, {bool lazy = true}) {
    _tryRegister<T>(() {
      if (!lazy) _instances[T] = construct();
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

/// An exception with the IoC container.
///
/// It is thrown when the type is already registered or with the attempt to get
/// a type that is not registered in the container.
class IocException implements Exception {
  final String message;

  IocException(this.message);

  @override
  String toString() {
    return "IocException: $message";
  }
}

class _IocDef<T> {
  T Function() construct;
  bool lazy;
  bool single;

  _IocDef(this.construct, {this.lazy = true, this.single = false});
}
