import 'package:flutter/material.dart';
import 'package:flutter_app_todo/widgets/task-tile.widget.dart';

class HomeScreenBody extends StatelessWidget {
  final taskList;

  HomeScreenBody({@required this.taskList});

  getCompletedTaskCount(List tasks) {
    return tasks.where((task) => task.status == 1).toList().length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'My tasks',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            '${getCompletedTaskCount(taskList)} of ${taskList.length}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return TaskTile(
                task: taskList[index],
              );
            },
          ),
        )
      ],
    );
  }
}
