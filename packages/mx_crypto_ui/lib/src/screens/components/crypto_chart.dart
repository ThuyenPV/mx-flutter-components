import 'package:flutter/material.dart';

class CryptoChart extends StatelessWidget {
  const CryptoChart({
    Key? key,
    this.onTap,
    this.color,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: color ?? Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
