class MenuItem {
  final String name;
  final int price;
  final int? discountPercent;

  const MenuItem({
    required this.name,
    required this.price,
    this.discountPercent,
  });
}