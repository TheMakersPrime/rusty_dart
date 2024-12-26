import 'package:rusty_dart/rusty_dart.dart';

void main() {
  fun1().match(
    ok: print,
    err: print,
  );
}

Result<String, Exception> consumeDoSomething() {
  final r2 = doSomething(0).unwrap();
  return Ok('consumerDoSomething() : $r2');
}

Result<String, Exception> doSomething(int index) {
  if (index == 0) {
    return Err(Error());
  }

Result<String, Error> fun3() {
  return Ok('fun3');
  // return Err(Error('fun3 error'));
}
