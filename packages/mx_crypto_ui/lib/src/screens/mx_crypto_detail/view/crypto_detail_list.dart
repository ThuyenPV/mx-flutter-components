import 'package:flutter/material.dart';

/// {@template crypto_detail_list}
/// A Dart class that exposes implement Crypto Detail List UI
/// {@endtemplate}
class CryptoDetailList extends StatelessWidget {
  /// {@macro crypto_detail_list}
  const CryptoDetailList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              height: 70,
              alignment: Alignment.center,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.25),
                ),
                title: Container(height: 30),
                subtitle: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
