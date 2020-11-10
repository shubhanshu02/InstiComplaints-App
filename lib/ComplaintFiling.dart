import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ComplaintFiling {
  final CollectionReference complaints =
      FirebaseFirestore.instance.collection('complaints');
  String complaintID =
      FirebaseFirestore.instance.collection('complaints').doc().id;

  Future fileComplaint(
      String title,
      String category,
      String description,
      List<String> images,
      DateTime filingTime,
      String status,
      List<String> upvotes,
      String uid,
      String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'list of my filed Complaints': FieldValue.arrayUnion([complaintID])
    });

    return await complaints.doc(complaintID).set({
      'title': title,
      'category': category,
      'description': description,
      'list of Images': images,
      'filing time': filingTime,
      'status': status,
      'upvotes': upvotes,
      'uid': uid,
      'email': email
    });
  }

  /*Future AddComplaintUID(String complaintID) async {
    return await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
      'list of my filled Complaints': FieldValue.arrayUnion([complaintID])
    });
  }*/
}
