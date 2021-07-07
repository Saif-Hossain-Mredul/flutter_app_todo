import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo/utilities/task-model.utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app_todo/BLoC/database_bloc.dart';
import 'package:flutter_app_todo/screens/addTask.Screen.dart';
import 'package:flutter_app_todo/widgets/home-screen-body.widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<DatabaseBloc>(context),
                child: AddTaskScreen(),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _firestore
              .collection('todos')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Icon(
                  Icons.list_alt,
                  color: Colors.deepOrange,
                  size: 80,
                ),
              );
            }

            List taskObjects = snapshot.data.documents
                .map((task) => Task.fromMap(task.data))
                .toList();
            print(taskObjects);

            return Padding(
              padding: EdgeInsets.only(top: 60, bottom: 5),
              child: HomeScreenBody(
                taskList: taskObjects,
              ),
            );
          },
        ),
      ),
    );
  }
}
