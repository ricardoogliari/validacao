import 'dart:js_interop';

void main() {
  Object obj = 1.toJS;
  if (obj.isA<JSNumber>()) {
    print('It is a JSNumber');
  } else {
    print('It is not a JSNumber');
  }
}
