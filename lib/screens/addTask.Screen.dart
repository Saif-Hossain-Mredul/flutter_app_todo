import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_todo/BLoC/database_bloc.dart';
import 'package:flutter_app_todo/utilities/task-model.utilities.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _firestore = Firestore.instance;

  String _title;
  String _priority = 'Medium';
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final List<String> _priorities = ['Low', 'Medium', 'High'];
  final _globalKey = GlobalKey<ScaffoldState>();

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });

      _dateController.text = DateFormat('MMM dd, yyyy').format(date);
    }
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('MMM dd, yyy').format(_date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _globalKey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                      size: 27,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add Task',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _title = value;
                      });
                    },
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onTap: _handleDatePicker,
                    // initialValue: DateFormat('MMM dd, yyy').format(_date),
                    controller: _dateController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Set Date',
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    value: _priority,
                    items: _priorities
                        .map(
                          (priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(
                              priority.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _priority = value;
                      });
                      FocusScope.of(context).unfocus();
                    },
                    icon: Icon(Icons.arrow_drop_down_circle),
                    iconSize: 25,
                    iconDisabledColor: Theme.of(context).primaryColor,
                    iconEnabledColor: Theme.of(context).primaryColor,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Set Importance',
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_title == null || _title.trim().isEmpty) {
                        final snackBar = SnackBar(
                          content: Text('Please set a task title'),
                        );

                        _globalKey.currentState.showSnackBar(snackBar);
                      } else {
                        Task task = Task();
                        DocumentReference documentRef = _firestore.collection('todos').document();

                        task.title = _title;
                        task.date = _date;
                        task.status = 0;
                        task.priority = _priority;

                        await documentRef.setData({
                          'title': _title,
                          'date': _date,
                          'status': 0,
                          'priority': _priority
                        });

                        print('uploaded');

                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'Set Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
