import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth.dart';

class Repository {

  Future<List<DocumentSnapshot>> get(String collection, String userEmail) async {
    Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
    if (userEmail.isNotEmpty) {
      var snapshot = await Firestore.instance
          .collection(collection)
          .where('user', isEqualTo: userEmail)
          .getDocuments();
      return snapshot.documents;
    }
    else{
      Auth.signOut();
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
