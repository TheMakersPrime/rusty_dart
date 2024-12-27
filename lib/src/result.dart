typedef OnMatch<R, V> = R Function(V);

sealed class Result<T extends Object?, E extends Exception> {
  const Result(this._value, this._error);

  final T? _value;
  final E? _error;

  /// Returns true if result is [Ok]
  bool get isOk => this is Ok;

  /// Returns true if result is [Ok]
  bool get isErr => !isOk;

  /// Returns true if result is [Ok] and the value inside of it
  /// matches a predicate
  bool isOkAnd(bool Function(T) f) {
    return match(
      ok: (x) => f(x),
      err: (_) => false,
    );
  }

  /// Returns true if result is [Err] and the value inside of it
  /// matches a predicate
  bool isErrAnd(bool Function(E) f) {
    return match(
      ok: (_) => false,
      err: (e) => f(e),
    );
  }

  /// Returns value held by [Ok] if [isOk]
  ///
  /// Else returns null
  T? get ok {
    if (isOk) return _value!;
    return null;
  }

  /// Returns value held by [Err] if [isErr]
  ///
  /// Else returns null
  E? get err {
    if (isOk) return null;
    return _error!;
  }

  /// Returns the value if [isOk]
  ///
  /// Else return nulls
  T? get unwrap => ok;

  /// Returns the contained [Ok] value or compute it from the given function
  T unwrapOrElse(T Function(E) op) {
    return match(
      ok: (x) => x,
      err: (e) => op(e),
    );
  }

  V match<V>({required OnMatch<V, T> ok, required OnMatch<V, E> err}) {
    if (isOk) return ok(_value as T);
    return err(_error!);
  }
}

class Ok<T extends Object, E extends Exception> extends Result<T, E> {
  Ok(T value) : super(value, null);
}

class Err<T extends Object, E extends Exception> extends Result<T, E> {
  Err(E error) : super(null, error);
}
