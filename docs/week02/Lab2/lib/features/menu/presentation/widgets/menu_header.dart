import 'package:flutter/material.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textColor = scheme.onPrimaryContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      color: scheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menu Hari Ini',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pilih menu, atur jumlah, lihat total di bawah.',
            style: TextStyle(fontSize: 13, color: textColor),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.storefront, size: 16, color: textColor),
              const SizedBox(width: 6),
              Text(
                'Buka 08.00 - 21.00',
                style: TextStyle(fontSize: 12, color: textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}