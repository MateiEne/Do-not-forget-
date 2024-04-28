import 'package:flutter/material.dart';

class NewItemDialog extends StatefulWidget {
  const NewItemDialog({
    super.key,
    required this.onSave,
  });

  final Function(String item) onSave;

  @override
  State<NewItemDialog> createState() => _NewItemDialogState();
}

class _NewItemDialogState extends State<NewItemDialog> {
  final TextEditingController controller = TextEditingController();
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Insert new item!"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: const Text("Item"),
          errorText: errorText == "" ? null : errorText,
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
            if (controller.text.trim().isEmpty) {
              setState(() {
                errorText = "Please enter an item!";
              });

              return;
            }
            widget.onSave(controller.text.trim());
          },
          child: const Text("Save!"),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
    );
  }
}
