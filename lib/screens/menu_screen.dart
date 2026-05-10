import 'package:flutter/material.dart';
import '../models/menu_data.dart';

class MenuScreen extends StatefulWidget {
  final CartController cart;
  final String? initialCategory;

  const MenuScreen({super.key, required this.cart, this.initialCategory});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);
  static const Color _grey = Color(0xFF666666);

  late String _selectedCat;
  final ScrollController _catScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedCat = widget.initialCategory ?? kCategories[0].id;
  }

  @override
  void dispose() {
    _catScroll.dispose();
    super.dispose();
  }

  List<MenuItem> get _filtered => kMenuItems.where((i) => i.categoryId == _selectedCat).toList();

  Category get _currentCat => kCategories.firstWhere((c) => c.id == _selectedCat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        children: [
          _buildHeader(),
          _buildCategoryTabs(),
          Expanded(child: _buildGrid()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
        child: Row(
          children: [
            if (Navigator.canPop(context))
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                ),
              ),
            if (Navigator.canPop(context)) const SizedBox(width: 12),
            const Text('Menu', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(width: 8),
            Text('القائمة', style: TextStyle(color: _grey, fontSize: 15)),
            const Spacer(),
            ListenableBuilder(
              listenable: widget.cart,
              builder: (_, __) => widget.cart.totalItems > 0
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('${widget.cart.totalItems} items', style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700)),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        controller: _catScroll,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: kCategories.length,
        itemBuilder: (ctx, i) {
          final cat = kCategories[i];
          final selected = cat.id == _selectedCat;
          return GestureDetector(
            onTap: () => setState(() => _selectedCat = cat.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? _accent : _surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? _accent : Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Text(
                cat.nameEn,
                style: TextStyle(
                  color: selected ? Colors.black : Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid() {
    final items = _filtered;
    if (items.isEmpty) {
      return Center(child: Text('No items', style: TextStyle(color: _grey)));
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.82,
      ),
      itemCount: items.length,
      itemBuilder: (ctx, i) => _ItemCard(item: items[i], cart: widget.cart, cat: _currentCat),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final MenuItem item;
  final CartController cart;
  final Category cat;

  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);

  const _ItemCard({required this.item, required this.cart, required this.cat});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: cart,
      builder: (_, __) {
        final qty = cart.quantityOf(item.id);
        return Container(
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    color: cat.accent.withValues(alpha: 0.12),
                  ),
                  child: Stack(
                    children: [
                      Center(child: Icon(cat.icon, color: cat.accent, size: 48)),
                      if (item.isPopular)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC9A84C).withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Popular', style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.w700)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.nameEn, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(item.nameAr, style: const TextStyle(color: Color(0xFF666666), fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('${item.price.toStringAsFixed(1)} JD', style: const TextStyle(color: _accent, fontSize: 13, fontWeight: FontWeight.w800)),
                        const Spacer(),
                        if (qty == 0)
                          GestureDetector(
                            onTap: () => cart.add(item),
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
                              child: const Icon(Icons.add, color: Colors.black, size: 18),
                            ),
                          )
                        else
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => cart.decrement(item.id),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
                                  child: const Icon(Icons.remove, color: Colors.white, size: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text('$qty', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                              ),
                              GestureDetector(
                                onTap: () => cart.add(item),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
                                  child: const Icon(Icons.add, color: Colors.black, size: 14),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
