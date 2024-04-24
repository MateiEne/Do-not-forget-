import 'package:flutter/material.dart';

class NewItem extends StatelessWidget {
  const NewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Insert new item!"),
      content: const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Item"),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pop();
          },
          child: const Text("Cancel!"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pop();
          },
          child: const Text("Save!"),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
    );
  }
}
