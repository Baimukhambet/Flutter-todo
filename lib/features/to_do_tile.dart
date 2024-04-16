import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatefulWidget {
  ToDoTile({ super.key, required this.taskText, required this.isFinished, this.deleteTapped, required this.index});
  final String taskText;
  bool isFinished;
  final int index;
  Function(int index)? deleteTapped;

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  void _boxChecked(bool? changed) {
    setState(() {
      widget.isFinished = !widget.isFinished;
    });
  }



  @override
  Widget build(BuildContext context){
    return Padding(
        padding: const EdgeInsets.only(left: 24, top: 16, right: 12),
        child: Slidable(
          endActionPane: ActionPane(motion: const ScrollMotion(), children: [SlidableAction(
            onPressed: (context) => widget.deleteTapped!(widget.index),
            icon: CupertinoIcons.trash,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Colors.red,
      )]),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(value: widget.isFinished, onChanged: _boxChecked),
                Text(widget.taskText, style: TextStyle(
                  decoration: (widget.isFinished) ? TextDecoration.lineThrough : TextDecoration.none
                ),)
              ],
            ),
          ),
        ),
      );
  }
}