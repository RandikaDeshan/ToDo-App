import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/src/models/taskmodel.dart';

class TaskService{
  final CollectionReference _reference = FirebaseFirestore.instance.collection("tasks");

  Future<void> saveTask(TaskModel taskModel)async{
    try{
      final TaskModel task = TaskModel(
          name: taskModel.name,
          priority: taskModel.priority,
          category: taskModel.category,
          color: taskModel.color,
          createdAt: DateTime.now(),
          userId: taskModel.userId,
          taskId: '',
          cateImg: taskModel.cateImg);

      final DocumentReference docRef = await _reference.add(task.toJson());
      await docRef.update({"taskId":docRef.id});
    }catch(error){
      print("Error : $error");
    }
  }

  Future<List<TaskModel>> getUserTasks(String userId)async{
    try{
      final tasks = await _reference.where('userId',isEqualTo: userId).get().then((snapshot){
        return snapshot.docs.map((doc){
          return TaskModel.fromJson(doc.data() as Map<String,dynamic>);
        }).toList();
      });
      return tasks;
    }catch(error) {
      print("Error : $error");
      return [];
    }
  }

  Future<void> updateTask(TaskModel task)async{
    await _reference.doc(task.taskId).update(task.toJson());
  }

  Future<TaskModel> getById(String taskId)async{
    return await _reference.doc(taskId).get().then((snapshot){
      return TaskModel.fromJson(snapshot.data() as Map<String,dynamic>);
    });
  }

  Future<void> deleteTask(taskId)async{
    await _reference.doc(taskId).delete();
  }
}