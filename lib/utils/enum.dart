// enum FoodCategory {
//   DRINKS('drinks'),
//   DAIRY('dairy'),
//   FOOD('food'),
//   MUNCHIES('munchies');

//   final String value;
//   const FoodCategory(this.value);

//   static FoodCategory fromValue(String value) {
//     if (value == 'drinks') {
//       return FoodCategory.DRINKS;
//     } else if (value == 'dairy') {
//       return FoodCategory.DAIRY;
//     } else if (value == 'food') {
//       return FoodCategory.FOOD;
//     } else if (value == 'munchies') {
//       return FoodCategory.MUNCHIES;
//     } else {
//       throw Exception('Invalid value: $value');
//     }
//   }
// }

enum CartItemChange {
  ADD(1),
  REMOVE(-1);

  final int value;
  const CartItemChange(this.value);
}
