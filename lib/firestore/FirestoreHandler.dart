import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskify/firestore/model/Task.dart';
import 'package:taskify/firestore/model/User.dart';

class FirestoreHandler{
  static CollectionReference<User> getUserCollection(){
    var firestore = FirebaseFirestore.instance;
    var collection = firestore.collection(User.collection).withConverter(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return User.fromFirestore(data);
      },
      toFirestore: (value, options) {
        return value.toFirestore();
      },
    );
    return collection;
  }
  static Future<void> createUser(User user){
    var collection = getUserCollection();
     var docRef = collection.doc(user.id);
     return docRef.set(user);
  }
  static Future<User?> ReadUser(String userId)async{
    var collection = getUserCollection();
    var docRef = collection.doc(userId);
    var docSnapshot = await docRef.get();
    return docSnapshot.data();
  }

  static CollectionReference<Task> getTaskCollection(String userId){
    var collection = getUserCollection().doc(userId).collection(Task.collectionName).withConverter(
      fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()),
      toFirestore: (value, options) => value.toFireStore(),);
  return collection;
  }
  static Future<void> createTask(Task task, String userId){
    var collection = getTaskCollection(userId);
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }
  static Future<List<Task>> GetTasks(String userId)async{
    var collection = getTaskCollection(userId);
    var tasksQuerySnapShot = await collection.get();
    var listTasksSnapshot = tasksQuerySnapShot.docs;
    var tasksList = listTasksSnapshot.map((snapshot) =>snapshot.data()).toList();
    return tasksList;
  }

  static Stream<List<Task>> GetTasksListen(String userId,DateTime selectedDate)async*{
    DateTime dayOnly = selectedDate.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      microsecond: 0,
      millisecond: 0,
    );
    var collection = getTaskCollection(userId).where(
      "date",isEqualTo: Timestamp.fromDate(dayOnly)
    );
    var tasksQuerySnapShot = collection.snapshots();
    var listTaskStream = tasksQuerySnapShot.map((querySnapshot) => querySnapshot.docs.map(
          (document) => document.data()).toList());
    yield* listTaskStream;
  }
  static Future<void> DeleteTask(String userId, String taskId){
    var collection = getTaskCollection(userId);
    return collection.doc(taskId).delete();
  }
}