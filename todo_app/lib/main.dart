import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo Project',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0x94A0EAFF),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ToDo-App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  final List<String> _todoItems = [];

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Please enter your ToDo: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: 500,
                child: TextField(
                  controller: myController,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ToDo:',
                      hintText: 'Enter Your ToDo'),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  _todoItems.add(myController.text);
                  myController.clear();
                });
              },
              child: const Text("Add ToDo"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) {
                  return _createTodo(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createTodo(int index) {
    return ListTile(
      title: GestureDetector(
          onTap: () {
            _editTodoItem(index);
          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  _todoItems[index],
                  style: const TextStyle(color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    // Add the delete functionality here
                    _deleteTodoItem(index);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                ),
              ],
            ),
          )),
    );
  }

  void _editTodoItem(int index) {
    String editedValue = _todoItems[index];

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit ToDo-Item'),
          content: TextField(
            controller: TextEditingController(text: _todoItems[index]),
            autofocus: true,
            onChanged: (newValue){
              editedValue = newValue;
            },
            onSubmitted: (newValue) {
              setState(() {
                _todoItems[index] = newValue;
              },
              );
              Navigator.of(context).pop(newValue);
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(editedValue);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((returnVal) {
      if (returnVal != null) {
        print('variable2: $returnVal');
        setState(() {
          _todoItems[index] = returnVal;
        });
      }
    });
  }

  void _deleteTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete ToDo-Item'),
          content: const Text('Are you sure you want to delete this ToDo Item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _todoItems.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
