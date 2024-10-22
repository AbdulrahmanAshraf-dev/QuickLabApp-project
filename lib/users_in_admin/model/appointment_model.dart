import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final DateTime date;
  final bool isInHome;
  final bool isCash;
  final List<Future<Product>> products;

  AppointmentModel({
    required this.date,
    required this.isInHome,
    required this.isCash,
    required this.products,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      date: (json['date'] as Timestamp).toDate(),
      isInHome: json['isInHome'],
      isCash: json['isCash'],
      products: (json['products'] as List)
          .map((productRef) => Product.fromDocumentReference(productRef))
          .toList(),
    );
  }
}

class Product {
  final String name;

  Product({
    required this.name,
  });

  // Replace DocumentReference with actual product details (name in this case)
  static Future<Product> fromDocumentReference(DocumentReference productRef) async {
    DocumentSnapshot productSnapshot = await productRef.get();
    String name = productSnapshot['name']; // Assuming 'name' is a field in the product document

    return Product(
      name: name,
    );
  }
}
