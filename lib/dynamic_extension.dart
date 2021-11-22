extension DynamicExtension<T> on T {
  R let<R>(R Function(T) fn) {
    return fn(this);
  }

  T also(Function(T) fn) {
    fn(this);
    return this;
  }
}
