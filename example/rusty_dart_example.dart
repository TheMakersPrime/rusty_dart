import 'package:rusty_dart/rusty_dart.dart';

void main() {
  consumeDoSomething().match(
    ok: print,
    err: print,
  );
}

Result<String, Error> consumeDoSomething() {
  final r2 = doSomething(0).unwrap();
  return Ok('consumerDoSomething() : $r2');
}

Result<String, Error> doSomething(int index) {
  if (index == 0) {
    return Err(Error());
  }

  return Ok('Success');
}
