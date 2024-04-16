import 'package:commerce/features/create_task_dialogue.dart';
import 'package:commerce/features/to_do_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ super.key });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tasks = Hive.box('tasks').get("TODOLIST");
  }

  TextEditingController _newTaskTextController = TextEditingController();

  void _deleteTapped(int index) {
    setState(() {
      tasks.removeAt(index);
      Hive.box('tasks').put("TODOLIST", tasks);
    });
  }

  void _cancelTapped() {
    Navigator.pop(context);
  }

  void _saveTapped() {
    if(_newTaskTextController.text.isNotEmpty) {
      setState((){
        final newTask = [_newTaskTextController.text, false];
        tasks.add(newTask);
        _newTaskTextController.clear();
        Hive.box('tasks').put("TODOLIST", tasks);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, i) => ToDoTile(taskText: tasks[i][0], isFinished: tasks[i][1], index: i, deleteTapped: _deleteTapped,),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(DialogRoute(context: context, builder: (context) => AlertDialog(
          title:const Text('Create new task'),
          content: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white54
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: TextField(
                controller: _newTaskTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
              )),
            ),
          ),
          actions: [TextButton(onPressed: (){_saveTapped();Navigator.pop(context);}, child: const Text('Save')), TextButton(onPressed: _cancelTapped, child: const Text('Cancel'))],
        )));
      },
        child: Icon(Icons.add)
      ),
    );
  }
}