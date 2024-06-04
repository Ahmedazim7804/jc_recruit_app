import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/service/food_service.dart';

class FoodRepository {
  FoodRepository(firestore) {
    foodService = FoodService(firestore);
  }

  late final FoodService foodService;

  Stream<List<FoodItem>> getFoods() {
    return foodService.getFoods().map((event) => event.docs
        .map((doc) =>
            FoodItem.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }
}
