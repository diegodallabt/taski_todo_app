import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;

  const Task({required this.title, required this.description});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  @override
  List<Object> get props => [title, description];
}
