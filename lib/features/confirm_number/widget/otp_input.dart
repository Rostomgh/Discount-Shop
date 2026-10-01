import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'otp_box.dart';

/// The row of code boxes.
///
/// One invisible TextField sits under the boxes and does the real input, so
/// the number keyboard, paste and SMS code autofill all work normally.
class OtpInput extends StatefulWidget {
  const OtpInput({super.key, this.length = 4, this.onChanged, this.onCompleted});

  final int length;
  final ValueChanged<String>? onChanged;

  /// Called once all [length] digits are entered.
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Rebuild the boxes when focus moves in or out.
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String code) {
    setState(() {});
    widget.onChanged?.call(code);
    if (code.length == widget.length) widget.onCompleted?.call(code);
  }

  @override
  Widget build(BuildContext context) {
    final code = _controller.text;
    final activeIndex = min(code.length, widget.length - 1);

    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              maxLength: widget.length,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              showCursor: false,
              enableInteractiveSelection: false,
              onChanged: _onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
        ),
        // Taps go through the boxes to the TextField underneath.
        IgnorePointer(
          // Codes read left to right, even in Arabic.
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                widget.length,
                (i) => OtpBox(
                  digit: i < code.length ? code[i] : null,
                  isActive: _focusNode.hasFocus && i == activeIndex,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
