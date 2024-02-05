import 'package:todo_app/infrastructure/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/presentation/todoHomepage/todo_homepage_controller.dart';

class NewTodoItem extends GetView<TodoHomepageController> {
  final TodoItem newTodoItem;

  const NewTodoItem({super.key, required this.newTodoItem});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TodoHomepageController());

    return ListTile(
      title: GestureDetector(
        onTap: () => _showEditConfirmationDialog(context, newTodoItem),
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(newTodoItem.name),
              /*Text(
                'Finish Date: ${newTodoItem.finishDate}',
                style: const TextStyle(color: Colors.black),
              ),*/
              IconButton(
                  onPressed: () {
                    controller.toggleDone(newTodoItem);
                    newTodoItem.done = true;
                    if (newTodoItem.done) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ToDo-Item done!')),
                      );
                    }
                  },
                  icon: newTodoItem.done
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank)),
              IconButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context, newTodoItem);
                },
                icon: const Icon(Icons.delete),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, TodoItem todoItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Todo Item'),
          content:
              const Text('Are you sure you want to delete this todo item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteTodoItem(todoItem);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditConfirmationDialog(
      BuildContext context, TodoItem todoItem) async {
    String editedValue = todoItem.name;
    TextEditingController editingController =
        TextEditingController(text: editedValue);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Edit ToDo-Item'),
              content: TextField(
                controller: editingController,
                autofocus: true,
                onChanged: (newValue) {
                  editedValue = newValue;
                },
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    todoItem.name = editedValue;
                    Get.find<TodoHomepageController>().editTodoItem(
                        todoItem.name, todoItem.done, todoItem.id);
                    Get.back(result: editedValue);
                    Get.find<TodoHomepageController>().onInit();
                  },
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel'),
                ),
              ]);
        }).then((returnVal) {
      if (returnVal != null) {
        todoItem.name = returnVal;
      }
    });
  }
}
