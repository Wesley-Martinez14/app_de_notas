class Note {
 int id;
 String title;
 String content;

  Note({
    required this.id, 
    required this.title, 
    required this.content
  });
Note.empty();
  Map<String, Object> toMap(){
  return {
      'id': id,
      'title': title,
      'content': content
    };
  }
}