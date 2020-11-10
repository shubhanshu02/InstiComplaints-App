import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateNotification {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference complaints =
      FirebaseFirestore.instance.collection('complaints');

  Stream<DocumentSnapshot> get userssnap {
    return users.doc(FirebaseAuth.instance.currentUser.uid).snapshots();
  }

  /*MailContent _mail;

  void _makeMailContent(complaintID) async {
    _mail = await complaints.doc().get().then((value) => MailContent(
      title: value.data()['title'],
      category: value.data()['category'],
      description: value.data()['description'],
      images: value.data()['list of Images'],
      filingTime: value.data()['filing time'],
      status: value.data()['status'],
      upvotes: value.data()['upvotes'],
    ));
  }*/
}

class ComplaintShow {
  final CollectionReference complaints =
      FirebaseFirestore.instance.collection('complaints');

  String complaintID;

  ComplaintShow(this.complaintID);

  Stream<DocumentSnapshot> get complaintsnap {
    return complaints.doc(complaintID).snapshots();
  }
}
