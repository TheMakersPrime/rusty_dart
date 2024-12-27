import 'package:rusty_dart/rusty_dart.dart';

void main() {
  final result = fun0();
  result.match(
    ok: (x) {
      // do something with the contained value
      print(x);
    },
    err: (e) {
      // do something with the contained error
      print(e);
    },
  );
}

Result<String, Exception> fun0() {
  return Ok('0');
}