import 'package:rusty_dart/src/error.dart';

sealed class Result<T extends Object, E extends Error> {
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
  }

  void match({required Function(T) ok, required Function(E) err}) {
    if (isOk) {
      ok(_value!);
    } else {
      err(_error!);
    }
  }
}

class Ok<T extends Object, E extends Error> extends Result<T, E> {
  Ok(T value) : super(value, null);
}

class Err<T extends Object, E extends Error> extends Result<T, E> {
  Err(E error) : super(null, error);
}
