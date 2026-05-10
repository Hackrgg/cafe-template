import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/menu_data.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  final CartController cart;
  final Function(int) onNavigate;

  const HomeScreen({super.key, required this.cart, required this.onNavigate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);
  static const Color _gold = Color(0xFFC9A84C);
  static const Color _grey = Color(0xFF666666);

  final List<MenuItem> _popular = kMenuItems.where((i) => i.isPopular).take(6).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          _buildBanner(),
          _buildSectionTitle('Categories', 'الأصناف'),
          _buildCategories(),
          _buildSectionTitle('Popular', 'الأكثر طلباً'),
          _buildPopular(),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader() {
    return SliverToBoxAdapter(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good morning ☕', style: TextStyle(color: _grey, fontSize: 13, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 2),
                  const Text('What are you having?', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                ],
              ),
              const Spacer(),
              Image.asset('assets/images/blk_logo.png', height: 40, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildBanner() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A1208), Color(0xFF2E1F10), Color(0xFF1A0A0A)],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _gold.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _gold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _gold.withValues(alpha: 0.3)),
                      ),
                      child: const Text('Limited Offer', style: TextStyle(color: _gold, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1)),
                    ),
                    const SizedBox(height: 10),
                    const Text('Buy 2 Get 1 Free', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    Text('On all Matcha drinks today', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13)),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () => widget.onNavigate(1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _accent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('Order Now', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSectionTitle(String en, String ar) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
        child: Row(
          children: [
            Text(en, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(width: 8),
            Text(ar, style: TextStyle(color: _grey, fontSize: 14, fontWeight: FontWeight.w400)),
            const Spacer(),
            GestureDetector(
              onTap: () => widget.onNavigate(1),
              child: Text('See all', style: TextStyle(color: _accent, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildCategories() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: kCategories.length,
          itemBuilder: (ctx, i) {
            final cat = kCategories[i];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => MenuScreen(cart: widget.cart, initialCategory: cat.id),
                ));
              },
              child: Container(
                width: 80,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: cat.accent.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(cat.icon, color: cat.accent, size: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(cat.nameEn, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SliverPadding _buildPopular() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.82,
        ),
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => _MenuCard(item: _popular[i], cart: widget.cart),
          childCount: _popular.length,
        ),
      ),
    );
  }
}

class _MenuCard extends StatefulWidget {
  final MenuItem item;
  final CartController cart;

  const _MenuCard({required this.item, required this.cart});

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard> {
  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);

  Category get _cat => kCategories.firstWhere((c) => c.id == widget.item.categoryId, orElse: () => kCategories[1]);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.cart,
      builder: (_, __) {
        final qty = widget.cart.quantityOf(widget.item.id);
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
                    color: _cat.accent.withValues(alpha: 0.12),
                  ),
                  child: Center(
                    child: Icon(_cat.icon, color: _cat.accent, size: 48),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item.nameEn, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(widget.item.nameAr, style: const TextStyle(color: Color(0xFF666666), fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('${widget.item.price.toStringAsFixed(1)} JD', style: const TextStyle(color: _accent, fontSize: 13, fontWeight: FontWeight.w800)),
                        const Spacer(),
                        if (qty == 0)
                          GestureDetector(
                            onTap: () => widget.cart.add(widget.item),
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
                                onTap: () => widget.cart.decrement(widget.item.id),
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
                                onTap: () => widget.cart.add(widget.item),
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
