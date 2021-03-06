import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyek_ambw_kel15/models/UserModel.dart';

CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("users");

class UserService {
  Future<void> tambahData({required UserModel user}) async {
    DocumentReference docRef = collectionRef.doc(user.id);

    await docRef
        .set(user.toJson())
        .whenComplete(() => print("Data Berhasil Ditambahkan"))
        .catchError((e) => print(e.toString()));
  }

  Future<UserModel> getUserByID(String id) async {
    try {
      DocumentSnapshot snapshot = await collectionRef.doc(id).get();

      return UserModel(
        id: id,
        email: snapshot['email'],
        name: snapshot['name'],
        balance: snapshot['balance'],
        locationid: snapshot['locationid'],
        city: snapshot['city'],
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> topUpWallet({required UserModel user}) async {
    DocumentReference docRef = collectionRef.doc(user.id);

    await docRef
        .update({"balance": user.balance})
        .whenComplete(() => print("Data Berhasil di Update"))
        .catchError((e) => print(e.toString()));
  }

  Future<void> potongSaldo(
      {required UserModel user, required int saldoAkhirUser}) async {
    DocumentReference docRef = collectionRef.doc(user.id);

    await docRef
        .update({"balance": saldoAkhirUser})
        .whenComplete(() => print("Data Berhasil di Update"))
        .catchError((e) => print(e.toString()));
  }

  Future<void> editProfile({required UserModel user}) async {
    DocumentReference docRef = collectionRef.doc(user.id);

    await docRef
        .update({
          "city": user.city,
          "name": user.name,
          "locationid": user.locationid
        })
        .whenComplete(() => print("Data Berhasil di Update"))
        .catchError((e) => print(e.toString()));
  }
}
