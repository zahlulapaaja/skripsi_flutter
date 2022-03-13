class Note {
  final int? id;
  final String? kodeButir;
  final String title;
  final String body;

  Note({
    this.id,
    this.kodeButir,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() {
    return 'Note {id: $id, title: $title, body: $body}';
  }
}
