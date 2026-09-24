import 'package:flutter/material.dart';

import 'features/menu/domain/menu_item.dart';
import 'features/menu/presentation/widgets/menu_empty_state.dart';
import 'features/menu/presentation/widgets/menu_header.dart';
import 'features/menu/presentation/widgets/menu_item_card.dart';
import 'features/menu/presentation/widgets/menu_search_field.dart';
import 'features/menu/presentation/widgets/menu_total_bar.dart';

void main() => runApp(const Lab02App());

class Lab02App extends StatelessWidget {
  const Lab02App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warung Digital',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF00696E)),
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<MenuItem> _items = [
    MenuItem(id: 'm1', name: 'Nasi Goreng Spesial', price: 18000, promo: true),
    MenuItem(id: 'm2', name: 'Mie Ayam Bakso', price: 15000),
    MenuItem(id: 'm3', name: 'Sate Ayam (10 tusuk)', price: 25000),
    MenuItem(id: 'm4', name: 'Ayam Geprek Sambal Matah', price: 20000, promo: true),
    MenuItem(id: 'm5', name: 'Soto Ayam Lamongan', price: 17000),
    MenuItem(id: 'm6', name: 'Es Teh Manis', price: 5000),
    MenuItem(id: 'm7', name: 'Es Jeruk Peras', price: 8000),
    MenuItem(id: 'm8', name: 'Kopi Susu Gula Aren', price: 12000),
  ];

  final Map<String, int> _quantities = {};

  late final TextEditingController _searchController;
  late final ScrollController _listController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _listController = ScrollController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listController.dispose();
    super.dispose();
  }

  List<MenuItem> get _visible => _items
      .where((i) =>
          _query.isEmpty ||
          i.name.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  int get _total => _items.fold(
      0, (sum, i) => sum + i.price * (_quantities[i.id] ?? 0));

  int get _lineCount => _quantities.values.where((q) => q > 0).length;

  void _setQuery(String value) => setState(() => _query = value);

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
  }

  void _changeQuantity(String id, int delta) {
    setState(() => _quantities[id] = (_quantities[id] ?? 0) + delta);
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pesanan disimpan: Rp $_total')),
    );
    setState(() => _quantities.clear());
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;

    return Scaffold(
      appBar: AppBar(title: const Text('Warung Digital')),
      body: Column(
        children: [
          const MenuHeader(),
          MenuSearchField(
            controller: _searchController,
            query: _query,
            onChanged: _setQuery,
            onClear: _clearSearch,
          ),
          Expanded(
            child: visible.isEmpty
                ? MenuEmptyState(query: _query, onClear: _clearSearch)
                : ListView.builder(
                    controller: _listController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: visible.length,
                    itemBuilder: (context, index) {
                      final item = visible[index];
                      return MenuItemCard(
                        item: item,
                        quantity: _quantities[item.id] ?? 0,
                        onIncrement: () => _changeQuantity(item.id, 1),
                        onDecrement: () => _changeQuantity(item.id, -1),
                      );
                    },
                  ),
          ),
          MenuTotalBar(
            lineCount: _lineCount,
            total: _total,
            onSave: _total == 0 ? null : _save,
          ),
        ],
      ),
    );
  }
}