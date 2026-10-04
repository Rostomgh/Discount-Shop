import 'bidi.dart';

final _nonBreakingSpace = String.fromCharCode(0xA0);

extension PriceFormat on num {
  /// 3150.4 -> "3 150", kept in order inside Arabic text. Add the currency
  /// after it.
  String get asPrice {
    final digits = round().abs().toString();
    final grouped = StringBuffer(this < 0 ? '-' : '');
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        grouped.write(_nonBreakingSpace);
      }
      grouped.write(digits[i]);
    }
    return grouped.toString().ltrIsolated;
  }
}
