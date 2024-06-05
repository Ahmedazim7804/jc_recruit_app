import 'package:equatable/equatable.dart';
import 'package:jc_recruit_app/utils/extensions.dart';

class CategoryItem extends Equatable {
  const CategoryItem({
    required this.id,
    required this.name,
    required this.image,
  });

  final String id;
  final String name;
  final String image;

  factory CategoryItem.fromJson(Map<String, dynamic> json, id) {
    return CategoryItem(
        id: id,
        name: (json['name'] as String).capitalize(),
        image: json['image']);
  }

  @override
  List<Object?> get props => [id, name, image];
}
