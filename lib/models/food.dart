import 'package:equatable/equatable.dart';
import 'package:jc_recruit_app/utils/enum.dart';

class FoodItem extends Equatable {
  final String name;
  final String imageUrl;
  final int price;
  final FoodCategory category;
  final bool available;
  final String? description;
  final String id;
  int quantity = 0;

  FoodItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.available,
    this.quantity = 0,
    this.description = '',
  });

  factory FoodItem.fromJson(Map<String, dynamic> json, String id) {
    String imageUrl =
        (json['name'] as String).toLowerCase().replaceAll(' ', '_');

    return FoodItem(
      id: id,
      name: json['name'],
      imageUrl: imageUrl,
      price: json['price'],
      category: FoodCategory.fromValue(json['category']),
      available: json['available'],
      description: json['description'] ?? "",
    );
  }

  @override
  List<Object?> get props => [name, imageUrl, price, category, available];

  FoodItem copyWith({
    String? name,
    String? imageUrl,
    int? price,
    FoodCategory? category,
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
      category: category ?? this.category,
      available: available ?? this.available,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }

  factory FoodItem.empty() {
    return FoodItem(
        id: "SDSD",
        name: "sds",
        imageUrl: "maggi",
        price: 23,
        category: FoodCategory.DAIRY,
        available: true);
  }
}
