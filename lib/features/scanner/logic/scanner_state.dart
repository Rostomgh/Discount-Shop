part of 'scanner_cubit.dart';

@freezed
sealed class ScannerState with _$ScannerState {
  /// The camera is looking for a QR code.
  const factory ScannerState.scanning() = ScannerScanning;

  /// A card was scanned ([scanned]) or typed; detection is ignored until
  /// [scanAgain].
  const factory ScannerState.found({
    required String code,
    @Default(true) bool scanned,
  }) = ScannerFound;
}
