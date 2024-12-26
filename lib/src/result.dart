sealed class Result<T extends Object, E extends Exception> {

typedef OnMatch<R, V> = R Function(V);

sealed class Result<T extends Object?, E extends Error> {
  const Result(this._value, this._error);

  final T? _value;
  final E? _error;

  // ------ Rust api ports start

  /// Returns true if result is [Ok]
  bool get isOk => this is Ok;

  /// Returns true if result is [Ok]
  bool get isErr => !isOk;

  /// Returns true if the result is [Ok] and the value inside of it matches a predicate.
  T? unwrap() {
    if (isErr) return null;

    return _value!;
  }

  // ------ Rust api ports end

  T propagate() {
    if (isOk) return _value!;

    throw _error!;
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

extension ExtensionX<T> on Result<T, Error> Function() {
  T propagate() {
    try {
      final result = this();

      if (result.isOk) return result._value!;

      throw result._error!;
    } on Error catch(e) {
      rethrow;
    }
  }
}
