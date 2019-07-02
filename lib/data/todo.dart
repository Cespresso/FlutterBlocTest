class Todo {
  final int id;
  final String title;
  final String body;
  final bool isCompleted;

  // private constructor
  Todo._(this.id, this.title, this.body, this.isCompleted);

  static Todo genWithUniqueID(String title,String body){
    return Todo._(new DateTime.now().millisecondsSinceEpoch,title,body,false);
  }
}