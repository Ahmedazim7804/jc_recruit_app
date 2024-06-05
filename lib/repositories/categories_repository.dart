import 'package:jc_recruit_app/models/category.dart';
import 'package:jc_recruit_app/service/category_service.dart';

class CategoryRepository {
  CategoryRepository(firestore) {
    _categoryService = CategoryService(firestore);
  }

  late final CategoryService _categoryService;

  Stream<List<CategoryItem>> getCategories() {
    return _categoryService.getCategories().map((event) {
      return event.docs.map((doc) {
        return CategoryItem.fromJson(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
