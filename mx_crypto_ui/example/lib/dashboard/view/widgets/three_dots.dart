import 'package:flutter/material.dart';

class ThreeDots extends StatelessWidget {
  const ThreeDots({
    super.key,
    this.amountDots = 3,
  });

  final int amountDots;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          height: 12,
          width: 12,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}
