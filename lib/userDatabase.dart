import 'package:cloud_firestore/cloud_firestore.dart';
import 'Complaint_Class.dart';

final databaseReference = FirebaseFirestore.instance;

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  CollectionReference refNotification =  databaseReference.collection("notifications");
  CollectionReference refBookmarks =  databaseReference.collection("bookmarks");
  CollectionReference refComplaints =  databaseReference.collection("usercomplaints");

  Future<void> addNotifications(String complaintId,Timestamp timeDate) async {
    await databaseReference.collection('notifications').doc(uid).collection('subCollection').doc().set({
      'complaint_id': complaintId,
      'DateTime': timeDate
    });
  }
  Future<void> addBookmarks(String complaintId) async {
    await databaseReference.collection('bookmarks').doc(uid).collection('subCollection').doc().set({
      'complaint_id': complaintId,
    });
  }


  Future<void> addComplaints(String complaintId) async {
    await databaseReference.collection('usercomplaints').doc(uid).collection('subCollection').doc().set({
      'complaint_id': complaintId,
    });
  }



}


