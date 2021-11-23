/// Extensions that apply to all objects.
extension DynamicExtension<T> on T {
  /// Calls the provided function with the value of `this` as its argument and
  /// returns the result.
  R let<R>(R Function(T) fn) {
    return fn(this);
  }

  /// Calls the provided function with the value of `this` as its argument and
  /// returns the `this` value.
  T also(Function(T) fn) {
    fn(this);
    return this;
  }
}
