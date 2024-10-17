class Task {
  int? id;
  String title;
  String description;
  DateTime? startDate;
  DateTime? endDate;
  DateTime createdAt;
  DateTime updatedAt;
  String priorityLevel;
  String status;
  int points;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.priorityLevel,
    required this.status,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
  }) : assert(points >= 0 && points <= 5, 'Points should be between 0 and 5');

  // Convert a Task into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'priorityLevel': priorityLevel,
      'status': status,
      'points': points,
    };
  }

  // Convert a Map into a Task object.
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      startDate: map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      points: map['points'],
      priorityLevel: map['priorityLevel'],
      status: map['status'],
    );
  }
}


