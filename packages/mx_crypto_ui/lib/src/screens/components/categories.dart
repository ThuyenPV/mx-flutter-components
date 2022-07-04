import 'package:flutter/material.dart';

/// {@template Categories}
/// A List Crypto Categories
/// {@endtemplate}
class Categories extends StatelessWidget {
  /// {@macro crypto_categories}
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: SizedBox(height: 50, width: 100),
          );
        },
      ),
    );
  }
}
