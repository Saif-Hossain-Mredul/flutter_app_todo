import 'package:flutter/cupertino.dart';
import 'package:flutter_app_todo/utilities/task-model.utilities.dart';

abstract class BlocEvent{}

class InsertEvent extends BlocEvent {
  String eventType = 'insert';
  Task task;

  InsertEvent({@required this.task});
}

class UpdateEvent extends BlocEvent {
  String eventType = 'update';
  Task task;

  UpdateEvent({@required this.task});
}

class DeleteEvent extends BlocEvent {
  String eventType = 'delete';
  Task task;

  DeleteEvent({@required this.task});
}
