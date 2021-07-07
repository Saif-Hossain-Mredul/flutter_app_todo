class Task {
  int id;
  String title;
  DateTime date;
  String priority;
  int status;

  Task({this.title, this.date, this.priority, this.status});

  Task.withID({this.id, this.title, this.date, this.priority, this.status});

  Map toMap() {
    final map = Map<String, dynamic>();

    if (id != null) {
      map["id"] = id;
    }

    map["title"] = title;
    map["date"] = date.toIso8601String();
    map["priority"] = priority;
    map["status"] = status;

    return (map);
  }

  factory Task.fromMap(Map map) {
    return Task(
      title: map['title'],
      date: (map['date'].toDate()),
      priority: map['priority'],
      status: map['status'],
    );
  }

// In normal constructor, an instance gets created and the final variables get instantiated with the initializer list.
// This is why there's no return statement. The instance to return is already fixed, when executing the constructor!
//
// In a factory constructor, the instance to return is decided by the method.
// That's why it needs a return statement and why it'll usually call a normal constructor in at least one path.
//
// So a factory does nothing different than a static method could do (in other languages often called getInstance()),
// except you cannot overload the constructor with a static method but you can with a factory method.
// I.e. factory methods are a way to hide the fact that the user of your class is not calling a constructor but a static method
//
}
