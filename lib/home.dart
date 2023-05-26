import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/model/todo_model.dart';
import 'package:provider_practice/provider/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();

  Future<void> _showDialogs() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add todo List'),
            content: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: "Write todo Item"),
            ), actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text('Cancel')),
            TextButton(onPressed: () {
              context.read<TodoProvider>().addTodoList(
                  TodoModel(title: _textController.text, isCompleted: false));
              _textController.clear();
              Navigator.pop(context);
            }, child: const Text('Submit')),
          ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                  child: const Center(
                    child: Text(
                      'TO DO List',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )),
            Expanded(
                flex: 3,
                child: ListView.builder(
                    itemCount: provider.allTodoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          provider.todoStatusChange(
                              provider.allTodoList[index]);
                        },
                        leading: MSHCheckbox(
                          size: 30,
                          value: provider.allTodoList[index].isCompleted,
                          colorConfig: MSHColorConfig
                              .fromCheckedUncheckedDisabled(
                              checkedColor: Colors.blue
                          ),
                          style: MSHCheckboxStyle.stroke,
                          onChanged: (bool selected) {
                            provider.todoStatusChange(
                                provider.allTodoList[index]);
                          },
                        ),
                        title: Text(
                          provider.allTodoList[index].title, style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration: provider.allTodoList[index].isCompleted
                              ? TextDecoration.combine(
                              [
                                TextDecoration.underline,
                                TextDecoration.lineThrough
                              ]) : null
                        ),
                        ),
                        trailing: IconButton(onPressed: (){
                          provider.removeTodoList(provider.allTodoList[index]);
                        }, icon: const Icon(Icons.delete_forever, color: Colors.red,)),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          _showDialogs();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
