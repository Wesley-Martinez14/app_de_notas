class Note {
  int id;
  String title;
  String content;

  Note({
    required this.id,
    required this.title,
    this.content = '', // Provide a default value for content
  });

  Note.empty()
      : id = 0,
        title = '',
        content = ''; // Initialize content in the empty constructor

  Map<String, Object> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
