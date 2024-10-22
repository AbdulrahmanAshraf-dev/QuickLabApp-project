import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsData {
  final String? name;
  final String? image;
  final num? price;
  final String? description;
  final String? id;
  final bool? isTest;
  bool? isBookmarked;
  bool? isInCart;
  static Set bookmarkedProducts={} ;
  static Set inCartProducts={};
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final String? _userID = FirebaseAuth.instance.currentUser?.uid;
  ProductsData( {this.isTest,this.id, this.description,  this.name,  this.image,  this.price,this.isBookmarked,this.isInCart});

  factory ProductsData.fromJson(Map<String, dynamic> json, String id, bool isTest) {
    return ProductsData(
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
      price: json['price'] ?? 0.0,
      description: json['description'] ?? 'Unknown',
      id: id,
      isTest: isTest,
      isBookmarked: bookmarkedProducts.contains(id)?true:false,
      isInCart: inCartProducts.contains(id)?true:false,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "image": image,
      "description": description,
      "id": id,
      "isTest": isTest,
      "price":price
    };
  }
  static Future<void> setBookmarkedProducts() async {

    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('users').doc(_userID).get();
    final bookmarks = querySnapshot['bookmarked'] as List<dynamic>;

    await Future.wait(bookmarks.map((doc) async {
      bookmarkedProducts.add(doc.toString().split('/')[1].split(')')[0]);
    }));

  }

  static Future<void> setInCartProducts() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
    await firestore.collection('users').doc(_userID).get();
    final bookmarks = querySnapshot['cart'] as List<dynamic>;

    await Future.wait(bookmarks.map((doc) async {
      inCartProducts.add(doc.toString().split('/')[1].split(')')[0]);
    }));

  }
}
