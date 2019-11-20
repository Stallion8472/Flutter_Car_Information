import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository {

  Future<List<DocumentSnapshot>> get(String collection) async {
    Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
    var user = await FirebaseAuth.instance.currentUser();
    if(user != null){
      var snapshot = await Firestore.instance
          .collection(collection)
          .where('user', isEqualTo: user.email)
          .getDocuments();
      return snapshot.documents;
    }
    else{
      return null;
    }
  }

  delete(String collection, String documentId){
    Firestore.instance.collection(collection).document(documentId).delete();
  }

  update(String collection, Map map, DocumentReference reference) {
    if (reference != null) {
      Firestore.instance
          .collection(collection)
          .document(reference.documentID)
          .updateData(map);
    } else {
      Firestore.instance.collection(collection).add(map);
    }
  }
}
