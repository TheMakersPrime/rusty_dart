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
    print('Panic : $_error!');
    exit(1);
  }

  // TODO (Ishwor) Name subjected to change
  T propagate() {
    if (isOk) {
      return _value!;
    }

    throw _error!;
  }
}

void match<T extends Object>(
  ResultFunc<T, Error> resultFunc, {
  required Function(T) ok,
  required Function(Error) err,
}) {
  _match(resultFunc, ok: ok, err: err);
}

void _match<T extends Object>(
  ResultFunc<T, Error> resultFunc, {
  required Function(T) ok,
  required Function(Error) err,
}) {
  try {
    final result = resultFunc();
    if (result.isOk) {
      ok(result._value!);
    } else {
      err(result._error!);
    }
  } on Error catch (e) {
    err(e);
  }
}

extension ResultFuncExtension<T extends Object, E extends Error> on ResultFunc<T, E> {
  void match({
    required Function(T) ok,
    required Function(Error) err,
  }) {
    _match(this, ok: ok, err: err);
  }
}

class Ok<T extends Object, E extends Exception> extends Result<T, E> {
  Ok(T value) : super(value, null);
}

class Err<T extends Object, E extends Exception> extends Result<T, E> {
  Err(E error) : super(null, error);
}
