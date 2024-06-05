import 'package:equatable/equatable.dart';
import 'package:jc_recruit_app/utils/extensions.dart';

class CategoryItem extends Equatable {
  const CategoryItem(
      {required this.id,
      required this.name,
      required this.image,
      this.selected = false});

  final String id;
  final String name;
  final String image;
  final bool selected;

  factory CategoryItem.fromJson(Map<String, dynamic> json, id) {
    return CategoryItem(
        id: id,
        name: (json['name'] as String).capitalize(),
        image: json['image']);
  }

  CategoryItem copyWith({
    String? id,
    String? name,
    String? image,
    bool? selected,
  }) {
    return CategoryItem(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        selected: selected ?? false);
  }

  @override
  List<Object?> get props => [id, name, image, selected];
}
