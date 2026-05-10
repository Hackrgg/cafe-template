import 'package:flutter/material.dart';
import '../models/menu_data.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final CartController cart;

  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);
  static const Color _grey = Color(0xFF666666);

  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: ListenableBuilder(
        listenable: cart,
        builder: (_, __) {
          final items = cart.items;
          return Column(
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Row(
                    children: [
                      const Text('Your Order', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                      const SizedBox(width: 8),
                      Text('طلبك', style: TextStyle(color: _grey, fontSize: 15)),
                      const Spacer(),
                      if (items.isNotEmpty)
                        GestureDetector(
                          onTap: cart.clear,
                          child: Text('Clear all', style: TextStyle(color: Colors.red.shade400, fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? _buildEmpty(context)
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                        itemCount: items.length,
                        itemBuilder: (ctx, i) => _CartRow(item: items[i], cart: cart),
                      ),
              ),
            ],
          );
        },
      ),
      bottomSheet: ListenableBuilder(
        listenable: cart,
        builder: (_, __) {
          if (cart.items.isEmpty) return const SizedBox.shrink();
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            decoration: BoxDecoration(
              color: _bg,
              border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.06))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('Total', style: TextStyle(color: _grey, fontSize: 15)),
                    const Spacer(),
                    Text('${cart.totalPrice.toStringAsFixed(2)} JD', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(cart: cart))),
                    child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: _surface, shape: BoxShape.circle, border: Border.all(color: Colors.white.withValues(alpha: 0.06))),
            child: Icon(Icons.coffee_outlined, color: _grey, size: 36),
          ),
          const SizedBox(height: 16),
          const Text('Your cart is empty', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Add something from the menu', style: TextStyle(color: _grey, fontSize: 14)),
        ],
      ),
    );
  }
}

class _CartRow extends StatelessWidget {
  final CartItem item;
  final CartController cart;

  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);
  static const Color _grey = Color(0xFF666666);

  const _CartRow({required this.item, required this.cart});

  Category get _cat => kCategories.firstWhere((c) => c.id == item.item.categoryId, orElse: () => kCategories[1]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _cat.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_cat.icon, color: _cat.accent, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.item.nameEn, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(item.item.nameAr, style: TextStyle(color: _grey, fontSize: 12)),
                const SizedBox(height: 6),
                Text('${item.totalPrice.toStringAsFixed(2)} JD', style: const TextStyle(color: _accent, fontSize: 14, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => cart.decrement(item.item.id),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.remove, color: Colors.white, size: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('${item.quantity}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                  GestureDetector(
                    onTap: () => cart.add(item.item),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(color: _accent.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.add, color: _accent, size: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
