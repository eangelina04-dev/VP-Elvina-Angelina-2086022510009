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

void main() {
  final menu = <MenuItem>[
    const MenuItem(name: 'Nasi Goreng Merah', price: 20000, discountPercent: 10),
    const MenuItem(name: 'Es Teh Hijau', price: 8000),
    const MenuItem(name: 'Mie Ayam', price: 12000, discountPercent: 15),
  ];

  // All names of menu items
  final names = menu.map((item) => item.name).toList();

  // Items under Rp 15,000
  final affordable = menu.where((item) => item.price < 15000).toList();

  // Total Price
  final totalPrice = menu.fold(0, (sum, item) => sum + item.finalPrice());

  print('Menu Names: $names');
  print('Items Under 15k: ${affordable.map((item) => item.name).toList()}');
  print('Total Price: $totalPrice');
  print('Nasi Goreng Merah Final Price: Rp ${menu[0].finalPrice()}');
}