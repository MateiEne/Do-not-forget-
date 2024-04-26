import 'package:flutter/material.dart';

class NewItem extends StatelessWidget {
  const NewItem({
    super.key,
    required this.onSave,
  });

  final Function(String item) onSave;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: const Text("Insert new item!"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
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
            onSave(controller.text.trim());
          },
          child: const Text("Save!"),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
    );
  }
}
