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
              padding: EdgeInsets.all(15),
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
        onTap: (){
          _editTodoItem(index);
        },
        child: Text(
          _todoItems[index],
          style: TextStyle(color: Colors.black),
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            _todoItems.removeAt(index);
          });
        },
        icon: const Icon(Icons.delete_forever),
      ),
    );
  }

  void _editTodoItem(int index) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit ToDo Item'),
          content: TextField(
            controller: TextEditingController(text: _todoItems[index]),
            autofocus: true,
            onSubmitted: (newValue) {
              setState(() {
                _todoItems[index] = newValue;
              });
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _todoItems[index] = myController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((returnVal) {
      if (returnVal != null) {
        setState(() {
          _todoItems[index] = returnVal;
        });
      }
    });


    /*return Positioned(
        child: Container(
            width: 400,
            color: Colors.lightGreen,
            alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name),
                    IconButton(
                      onPressed: () {}, icon: const Icon(Icons.delete_forever),
                    )
                  ],
                ),
            )
    );*/
  }
}
