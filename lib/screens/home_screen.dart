import 'package:dont_forget/widgets/new_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> _items = [];

  void _newItemButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const NewItem(),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Do not forget!',
        ),
        centerTitle: true,
      ),
      body: ReorderableListView(
        children: <Widget>[
          for (int i = 0; i < _items.length; i++)
            ListTile(
              key: Key('$i'),
              tileColor: _items[i].isOdd ? oddItemColor : evenItemColor,
              title: Text("Item ${_items[i]}"),
              trailing: const Icon(Icons.drag_handle_sharp),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final int item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _newItemButtonPressed(context);
        },
        label: const Text("New item"),
        icon: const Icon(
          Icons.add,
        ),
        backgroundColor: Theme.of(context).highlightColor,
      ),
    );
  }
}
