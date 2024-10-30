import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel{
  final String taskId;
  final String name;
  final String userId;
  final int priority;
  final String category;
  final String color;
  final String cateImg;
  final DateTime? createdAt;

  TaskModel({
    required this.taskId,
    required this.name,
    required this.priority,
    required this.category,
    required this.color,
    this.createdAt,
    required this.userId,
    required this.cateImg
  });

  factory TaskModel.fromJson(Map<String,dynamic> json){
    return TaskModel(
        name: json['name'],
        priority: json['priority'],
        category: json['category'],
        color: json['color'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        userId: json['userId'],
        taskId: json['taskId'],
        cateImg: json['cateImg'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'name' : name,
      'priority' : priority,
      'category' : category,
      'color' : color,
      'createdAt' :Timestamp.fromDate(createdAt!),
      'userId' : userId,
      'taskId' : taskId,
      'cateImg' : cateImg
    };
  }
}