enum SortBy {
  NAME('name'),
  PRICE('price');

  final String value;
  const SortBy(this.value);
}

enum Sort {
  ASCENDING(1),
  DESCENDING(2);

  final int value;
  const Sort(this.value);
}

enum CartItemChange {
  ADD(1),
  REMOVE(-1);

  final int value;
  const CartItemChange(this.value);
}
