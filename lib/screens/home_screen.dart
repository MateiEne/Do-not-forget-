import 'package:dont_forget/widgets/new_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _items = [];

  void _newItemButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => NewItem(onSave: _addItem),
      barrierDismissible: false,
    );
  }

  void _addItem(String item) {
    setState(() {
      _items.add(item);

      print(_items);

      Navigator.of(
        context,
        rootNavigator: true,
      ).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);


    /// TODO: make sure that it can add equal items and remove and undo the remove on items list
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Do not forget!',
        ),
        centerTitle: true,
      ),
      body: ReorderableListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey<String>(_items[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              color: Colors.red,
            ),
            onDismissed: (direction) {
              setState(() {
                _items.removeAt(index);
              });

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(
                    seconds: 3,
                  ),
                  content: Text("${_items[index]} removed"),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        _items.insert(index, _items[index]);
                      });
                    },
                  ),
                ),
              );
            },
            child: ListTile(
              tileColor: index.isOdd ? oddItemColor : evenItemColor,
              title: Text(_items[index]),
              trailing: const Icon(Icons.drag_handle_sharp),
            ),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final String item = _items.removeAt(oldIndex);
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
