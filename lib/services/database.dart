import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/coffee.dart';
import 'package:coffee/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  Stream<UserData> get userData {
    return coffeeCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  final CollectionReference coffeeCollection =
      Firestore.instance.collection('coffee');

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Coffee> _cofeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Coffee(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? ' 0',
      );
    }).toList();
  }

  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots().map(_cofeeListFromSnapshot);
  }
}
