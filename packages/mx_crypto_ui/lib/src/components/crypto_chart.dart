import 'package:flutter/material.dart';

/// {@template crypto_chart}
/// A Dart class that exposes implement Crypto Chart UI
/// {@contemplate}
class CryptoChart extends StatelessWidget {
  /// {@macro crypto_chart}
  const CryptoChart({
    super.key,
    this.onTap,
    this.color,
    required this.title,
  });

  /// {@macro event when user clicks on crypto chart}
  final GestureTapCallback? onTap;

  /// {@macro change background color for crypto chart}
  final Color? color;

  /// {@macro change center title for crypto chart}
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: color ?? Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(title),
        ),
      ),
    );
  }
}
