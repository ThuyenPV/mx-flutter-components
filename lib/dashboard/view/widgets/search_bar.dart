import "package:flutter/material.dart";

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.25),
          ),
        ),
      ),
    );
  }
}
