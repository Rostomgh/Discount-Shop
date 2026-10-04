// Unicode "left-to-right isolate" start and end. Wrapping numbers in them
// keeps "3 150", "-30%" or "+213 ..." in the right order inside Arabic text.
final _ltrIsolateStart = String.fromCharCode(0x2066);
final _ltrIsolateEnd = String.fromCharCode(0x2069);

extension LtrIsolate on String {
  String get ltrIsolated => '$_ltrIsolateStart$this$_ltrIsolateEnd';
}
