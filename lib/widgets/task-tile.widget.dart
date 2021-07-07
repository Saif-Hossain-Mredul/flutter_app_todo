import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_todo/BLoC/database_bloc.dart';
import 'package:flutter_app_todo/utilities/task-model.utilities.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            BlocProvider.of<DatabaseBloc>(context).add(DeleteEvent(task: task));
          },
        ),
      ],
      child: ListTile(
        title: Text(
          '${task.title}',
          style: TextStyle(
              decoration: task.status == 1
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        subtitle: Text(
          '${DateFormat('MMM dd, yyyy').format(task.date)} ⚫ ${task.priority}',
          style: TextStyle(
              decoration: task.status == 1
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        // trailing: Checkbox(
        //   value: task.status == 1 ? true : false,
        //   onChanged: (newVal) {
        //     task.status = newVal ? 1 : 0;
        //     // _dataBloc.eventControllerSink.add(UpdateEvent(task: task));
        //     BlocProvider.of<DatabaseBloc>(context).add(UpdateEvent(task: task));
        //   },
        // ),
      ),
    );
  }
}
