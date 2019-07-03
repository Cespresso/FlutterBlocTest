class Todo {
  final int id;
  String title;
  String body;
  bool isCompleted;

  // private constructor
  Todo._(this.id, this.title, this.body, this.isCompleted);

  static Todo genWithUniqueID(String title,String body){
    return Todo._(new DateTime.now().millisecondsSinceEpoch,title,body,false);
  }
}