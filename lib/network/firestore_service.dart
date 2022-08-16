import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_num2/helpers/main_user.dart';
import 'package:e_commerce_num2/models/order_model.dart';
import 'package:e_commerce_num2/models/user_model.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  final _db = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getCategories() async {
    return await _db.collection("categories").doc("items").get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) async {
    return await _db.collection("users").doc(uid).get();
  }

  Future<void> saveUser(UserModel model) async {
    await _db.collection("users").doc(model.uId).set(model.toMap);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProducts() async {
    return await _db.collection("products").get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchProducts(String text) async {
    return await _db.collection("products").where("keywords", arrayContains: text).get();
  }

  Future<void> updateUser(UserModel model) async {
    await _db.collection("users").doc(model.uId!).set(model.toMap);
  }

  Future<DocumentReference<Map<String, dynamic>>> addOrder(OrderModel order) async {
    return await _db
        .collection("users")
        .doc(MainUser.model?.uId)
        .collection("orders")
        .add(order.toMap());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOrders() async {
    return await _db.collection("users").doc(MainUser.model?.uId).collection("orders").get();
  }
}
