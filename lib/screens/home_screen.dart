import 'package:dont_forget/widgets/new_item.dart';
import 'package:dont_forget/widgets/new_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _items = [];

  void _newItemButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => NewItemDialog(onSave: _addItem),
      barrierDismissible: false,
    );
  }

  void _addItem(String item) async {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pop();

    if (_items.contains(item)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Text("$item is already in the list"),
        ),
      );

      return;
    }

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _items.add(item);

      prefs.setStringList('items', _items);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _items = prefs.getStringList('items') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    Widget mainContent = const Center(
      child: Text("No items added yet."),
    );

    if (_items.isNotEmpty) {
      mainContent = ReorderableListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(_items[index]),
            direction: DismissDirection.endToStart,
            background: Card(
              color: Colors.red,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Remove item",
                  ),
                ),
              ),
            ),
            onDismissed: (direction) async {
              final int itemIndex = index;
              final String item = _items[itemIndex];

              final prefs = await SharedPreferences.getInstance();

              setState(() {
                _items.removeAt(index);

                prefs.setStringList('items', _items);
              });

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(
                    seconds: 3,
                  ),
                  content: Text("$item removed"),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      setState(() {
                        _items.insert(itemIndex, item);

                        prefs.setStringList('items', _items);
                      });
                    },
                  ),
                ),
              );
            },
            child: NewItem(
              item: _items[index],
            ),
          );
        },
        onReorder: (int oldIndex, int newIndex) async {
          final prefs = await SharedPreferences.getInstance();

          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final String item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);

            prefs.setStringList('items', _items);
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Do not forget!',
        ),
      ),
      body: mainContent,
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
