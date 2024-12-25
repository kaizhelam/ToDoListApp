import 'package:flutter/material.dart';
import 'package:myfirstapp/provider/todolist_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _listTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDoApp",
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _listTextEditingController,
                    decoration: InputDecoration(
                        labelText: "Enter an Item",
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.yellow),
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    if (_listTextEditingController.text.isEmpty) {
                      return;
                    }
                    context
                        .read<TodolistProvider>()
                        .addItem(_listTextEditingController.text);
                    _listTextEditingController.clear();
                  },
                  child: Text("Add"),
                )
              ],
            ),
            Expanded(child: Consumer<TodolistProvider>(
              builder: (context, value, child) {
                final todolist = value.getAllItems;

                return todolist.isEmpty
                    ? Center(
                        child: Text(
                          "Empty ToDo List",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: value.getAllItems.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Checkbox(
                                  value: todolist[index]['ischeck'],
                                  onChanged: (bool? isChecked) {
                                    context
                                        .read<TodolistProvider>()
                                        .updateCheckbox(index, isChecked!);
                                  },
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      context
                                          .read<TodolistProvider>()
                                          .removeItem(index);
                                    },
                                    icon: Icon(Icons.remove)),
                                title: Text(
                                  todolist[index]['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      decoration: todolist[index]['ischeck']
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                ),
                                subtitle: Text(context
                                    .read<TodolistProvider>()
                                    .formatDateTime(todolist[index]['Time'])),
                              );
                            }),
                      );
              },
            ))
          ],
        ),
      ),
    );
  }
}
