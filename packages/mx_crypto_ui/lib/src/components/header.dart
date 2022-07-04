import 'package:flutter/material.dart';
import 'package:mx_share_api/mx_share_api.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.crypto,
  }) : super(key: key);

  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(crypto.image),
          backgroundColor: Colors.grey.withOpacity(0.25),
        ),
        trailing: Text('${crypto.currentPrice}'),
        title: Text(crypto.name),
        subtitle: Text(crypto.symbol.toUpperCase()),
      ),
    );
  }
}
