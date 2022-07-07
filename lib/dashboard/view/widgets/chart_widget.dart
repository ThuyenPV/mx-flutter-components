import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.25),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Container(
                height: 200,
                alignment: Alignment.center,
                child: const Text('DASHBOARD SCREEN'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
