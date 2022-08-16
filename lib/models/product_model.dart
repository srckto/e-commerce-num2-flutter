import 'package:e_commerce_num2/models/review_model.dart';

class ProductModel {
  String? id;
  String? title;
  String? brand;
  String? category;
  List<String>? colors = [];
  String? condition;
  String? fitting;
  String? image;
  String? material;
  String? name;
  double? price;
  double? rating;
  int? sku;
  List<String>? sizes = [];
  List<ReviewModel>? reviews = [];
  ProductModel({
    this.id,
    this.brand,
    this.category,
    this.colors,
    this.condition,
    this.fitting,
    this.image,
    this.material,
    this.name,
    this.price,
    this.rating,
    this.sku,
    this.sizes,
    this.title,
    this.reviews,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'brand': brand,
      'category': category,
      'colors': colors,
      'condition': condition,
      'fitting': fitting,
      'image': image,
      'material': material,
      'name': name,
      'price': price,
      'rating': rating,
      'sku': sku,
      'sizes': sizes,
      'reviews': reviews?.map((e) => e.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      brand: map['brand'],
      category: map['category'],
      colors: List<String>.from(map['colors']),
      condition: map['condition'],
      fitting: map['fitting'],
      image: map['image'],
      material: map['material'],
      name: map['name'],
      price: map['price']?.toDouble(),
      rating: map['rating']?.toDouble(),
      sku: map['sku']?.toInt(),
      sizes: List<String>.from(map['sizes']),
      reviews: map["reviews"] == null ? null : List<ReviewModel>.from(map["reviews"]?.map((e) => ReviewModel.fromMap(e))),
    );
  }
}
