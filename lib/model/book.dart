final String tableBooks = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, title, description, time, imagePath
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
  static const String imagePath = 'imagePath';
}

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;
  final String? imagePath;

  const Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
    this.imagePath,
  });

  Note copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
    String? imagePath,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
        imagePath: imagePath ?? this.imagePath,
      );

  static Note fromJson(Map<String, Object?> json) {
    final imagePath = json[NoteFields.imagePath] as String?;
    return Note(
      id: json[NoteFields.id] as int?,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      createdTime: DateTime.parse(json[NoteFields.time] as String),
      imagePath: imagePath,
    );
  }

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
        NoteFields.imagePath: imagePath,
      };
}
