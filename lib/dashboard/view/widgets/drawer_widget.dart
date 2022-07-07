import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    this.onTap,
    this.color,
  });

  final GestureTapCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: color ?? Colors.grey.withOpacity(0.25),
      ),
      title: Container(
        height: 30,
        decoration: BoxDecoration(
          color: color ?? Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
