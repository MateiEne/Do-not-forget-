import 'package:flutter/material.dart';

class NewItem extends StatelessWidget {
  const NewItem({
    super.key,
    required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Card(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        child: ListTile(
          key: ValueKey<String>(item),
          title: Text(item),
          trailing: const Icon(Icons.drag_handle_sharp),
        ),
      ),
    );
  }
}
