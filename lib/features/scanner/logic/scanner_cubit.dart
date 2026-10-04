import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanner_state.dart';
part 'scanner_cubit.freezed.dart';

/// The member card being checked on the scanner tab. The member and their
/// offers are shown by the member_validation feature.
class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit() : super(const ScannerState.scanning());

  /// Digits of a card number, printed under its QR code.
  static const cardDigits = 12;

  /// A QR code seen by the camera, or a number typed in manual entry
  /// ([scanned] false). Ignored while a card is already shown, since the
  /// camera keeps sending the same code.
  void cardFound(String code, {bool scanned = true}) {
    final trimmed = code.trim();
    if (state is ScannerScanning && trimmed.isNotEmpty) {
      emit(ScannerState.found(code: trimmed, scanned: scanned));
    }
  }

  void scanAgain() => emit(const ScannerState.scanning());

  /// "094281339901" → "0942 8133 9901". Other codes are returned unchanged.
  static String formatCode(String code) {
    if (!RegExp(r'^\d+$').hasMatch(code)) return code;
    final groups = [
      for (var i = 0; i < code.length; i += 4)
        code.substring(i, i + 4 > code.length ? code.length : i + 4),
    ];
    return groups.join(' ');
  }
}
