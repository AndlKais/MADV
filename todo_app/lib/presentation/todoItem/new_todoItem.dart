import 'package:todo_app/infrastructure/todoItem.dart';
import 'package:flutter/material.dart';

class NewTodoItem extends StatelessWidget {
  final TodoItem newtodoItem;

  const NewTodoItem({super.key, required this.newtodoItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
    title: GestureDetector(
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
            Text(
                newtodoItem.title,
            ),
            Text(
              'Finish Date: ${newtodoItem.finishDate}',
              style: const TextStyle(color: Colors.black),
              ),
            IconButton(
                  onPressed: () {
                    // Add the delete functionality here
                   /* _deleteTodoItem(index);*/
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
}

  
   
            
              
             