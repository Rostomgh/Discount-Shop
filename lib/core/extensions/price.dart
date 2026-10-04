import 'bidi.dart';

final _nonBreakingSpace = String.fromCharCode(0xA0);

extension PriceFormat on num {
  /// 3150.4 -> "3 150", kept in order inside Arabic text. Add the currency
  /// after it.
  String get asPrice => _format(this < 0 ? '-' : '');

  /// Like [asPrice] with a sign in front: "+450", "-18 500".
  String get asSignedPrice => _format(this < 0 ? '-' : '+');

  String _format(String sign) {
    final digits = round().abs().toString();
    final grouped = StringBuffer(sign);
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        grouped.write(_nonBreakingSpace);
      }
      grouped.write(digits[i]);
    }
    return grouped.toString().ltrIsolated;
  }
}
