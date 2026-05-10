class Note {
  final String id;
  final String title;
  final String content;
  final String userId;

  Note({required this.id, required this.title, required this.content, required this.userId});

  factory Note.fromRecord(Map<String, dynamic> data, String id) {
    return Note(id: id, title: data['TITLE'] ?? '', content: data['CONTENT'] ?? '', userId: data['USER_ID'] ?? '');
  }
}
