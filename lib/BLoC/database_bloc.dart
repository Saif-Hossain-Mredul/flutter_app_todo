import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_app_todo/services/sql/database-helper.service.dart';
import 'package:flutter_app_todo/utilities/task-model.utilities.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(DatabaseInitialState());

  @override
  Stream<DatabaseState> mapEventToState(
    DatabaseEvent event,
  ) async* {
    final _dataBase = DatabaseHelper.instance;

    if (event is InitEvent) {
      yield DatabaseLoadingState();
      final taskList = await _dataBase.getTaskList();
      yield DatabaseLoadedState(taskList: taskList);
    } else if (event is InsertEvent) {
      _dataBase.insertTask(event.task);

      final taskList = await _dataBase.getTaskList();
      yield DatabaseLoadedState(taskList: taskList);
    } else if (event is UpdateEvent) {
      _dataBase.updateTask(event.task);

      final taskList = await _dataBase.getTaskList();
      yield DatabaseLoadedState(taskList: taskList);
    } else if (event is DeleteEvent) {
      _dataBase.deleteTask(event.task.id);

      final taskList = await _dataBase.getTaskList();
      yield DatabaseLoadedState(taskList: taskList);
    }
  }
}
