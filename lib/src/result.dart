sealed class Result<T extends Object, E extends Exception> {
  const Result(this._value, this._error);

  final T? _value;
  final E? _error;

  /// Returns true if result is Ok
  bool get isOk => this is Ok;

  /// Returns true if result is Ok
  bool get isErr => !isOk;

  T unwrap() {
    if (isOk) {
      return _value!;
    }
    throw 'Panic';
  }

  // TODO (Ishwor) Find a way to propagate error up the function
  T propagate() {
    if (isOk) {
      return _value!;
    }

    throw _error!;
  }

  X match<X>({required X Function(T) ok, required X Function(E) err}) {
    if (isOk) {
      return ok(_value!);
    } else {
      return err(_error!);
    }
  }
}

class Ok<T extends Object, E extends Exception> extends Result<T, E> {
  Ok(T value) : super(value, null);
}

class Err<T extends Object, E extends Exception> extends Result<T, E> {
  Err(E error) : super(null, error);
}
