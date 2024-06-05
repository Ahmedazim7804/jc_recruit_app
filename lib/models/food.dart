import 'package:equatable/equatable.dart';
import 'package:jc_recruit_app/utils/enum.dart';

class FoodItem extends Equatable {
  final String name;
  final String imageUrl;
  final int price;
  final String categoryId;
  final bool available;
  final String? description;
  final String id;
  int quantity = 0;

  FoodItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.categoryId,
    required this.available,
    this.quantity = 0,
    this.description = '',
  });

  factory FoodItem.fromJson(Map<String, dynamic> json, String id) {
    return FoodItem(
      id: id,
      name: json['name'],
      imageUrl: json['image'],
      price: json['price'],
      categoryId: json['category'],
      available: json['available'],
      description: json['description'] ?? "",
    );
  }

  @override
  List<Object?> get props => [name, imageUrl, price, categoryId, available];

  FoodItem copyWith({
    String? name,
    String? imageUrl,
    int? price,
    String? categoryId,
    bool? available,
    String? description,
    String? id,
    int? quantity,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      available: available ?? this.available,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }
}
