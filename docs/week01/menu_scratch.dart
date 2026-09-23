class MenuItem {
  final String name;
  final int price;
  final int? discountPercent;

  const MenuItem({
    required this.name,
    required this.price,
    this.discountPercent,
  });

  int finalPrice() {
    final discount = discountPercent;
    if (discount == null) return price;
    return (price * (100 - discount) / 100).round();
    }
  }

}