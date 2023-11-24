class Message {
  static const String columnText = 'text';
  static const String columnTitle = 'title';

  final String title;
  final String text;
  Message({required this.title, required this.text});

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      columnTitle: title,
      columnText: text,
    };
    return map;
  }

  static Message fromMap(Map map) {
    return Message(text: map[columnText], title: map[columnTitle]);
  }
}