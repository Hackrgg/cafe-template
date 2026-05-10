import 'dart:async';
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
  static const Color _accent = Color(0xFFF5F0E8);

  late final PageController _pageController;
  late final PageController _bannerController;
  Timer? _bannerTimer;
  int _currentIndex = 0;
  int _bannerIndex = 0;

  static const List<_PromoItem> _promos = [
    _PromoItem(
      label: 'HAPPY HOUR',
      labelAr: 'ساعة سعيدة',
      title: '20% off all espresso drinks',
      sub: 'Every day 2–5 PM',
      icon: Icons.local_cafe_rounded,
      colors: [Color(0xFF1A1410), Color(0xFF0F0C09)],
      accent: Color(0xFFF5F0E8),
    ),
    _PromoItem(
      label: 'NEW',
      labelAr: 'جديد',
      title: 'Oat Milk Latte is here',
      sub: 'Creamy, plant-based & bold',
      icon: Icons.eco_rounded,
      colors: [Color(0xFF111411), Color(0xFF0C0F0C)],
      accent: Color(0xFFC9A84C),
    ),
    _PromoItem(
      label: 'LOYALTY',
      labelAr: 'الولاء',
      title: 'Earn a free drink at 10 stamps',
      sub: 'Collect a stamp every order',
      icon: Icons.star_rounded,
      colors: [Color(0xFF161410), Color(0xFF0F0D09)],
      accent: Color(0xFFC9A84C),
    ),
  ];

  final List<_FeaturedItem> _featured = const [
    _FeaturedItem(
      name: 'Mocha',
      nameAr: 'موكا',
      subtitle: 'Chocolate & creamy',
      imagePath: 'assets/images/mocha.png',
      description: 'Rich espresso mixed with smooth milk and deep chocolate notes.',
      price: 3.0,
      rating: 4.8,
      accentColor: Color(0xFFC9A84C),
      gradient: [Color(0xFF0D0B09), Color(0xFF111009), Color(0xFF0A0A0A)],
    ),
    _FeaturedItem(
      name: 'Espresso',
      nameAr: 'اسبريسو',
      subtitle: 'Strong & bold',
      imagePath: 'assets/images/expresso.png',
      description: 'Pure and intense coffee taste for those who love a sharp energy kick.',
      price: 2.5,
      rating: 4.9,
      accentColor: Color(0xFFF5F0E8),
      gradient: [Color(0xFF0A0A0A), Color(0xFF0D0D0D), Color(0xFF0A0A0A)],
    ),
    _FeaturedItem(
      name: 'Latte',
      nameAr: 'لاتيه',
      subtitle: 'Soft & milky',
      imagePath: 'assets/images/latte.png',
      description: 'A softer coffee experience with silky steamed milk and balanced taste.',
      price: 4.0,
      rating: 4.7,
      accentColor: Color(0xFFC9A84C),
      gradient: [Color(0xFF0C0B09), Color(0xFF100F0D), Color(0xFF0A0A0A)],
    ),
  ];

  _FeaturedItem get _current => _featured[_currentIndex];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.82);
    _bannerController = PageController(viewportFraction: 0.92);
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_bannerIndex + 1) % _promos.length;
      _bannerController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bannerController.dispose();
    _bannerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _current.gradient,
        ),
      ),
      child: Stack(
        children: [
          _AnimatedGlow(color: _current.accentColor),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('قهوة زاكية. كل يوم.', style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 12, fontWeight: FontWeight.w400)),
                          const SizedBox(height: 2),
                          const Text("What's your order?", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      const Spacer(),
                      Image.asset('assets/images/blk_logo.png', height: 36, color: Colors.white),
                    ],
                  ),
                ),

                // Cup carousel
                Expanded(
                  flex: 10,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _featured.length,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    itemBuilder: (ctx, i) {
                      final item = _featured[i];
                      final isActive = i == _currentIndex;
                      return AnimatedPadding(
                        duration: const Duration(milliseconds: 320),
                        curve: Curves.easeOut,
                        padding: EdgeInsets.only(
                          left: 6, right: 6,
                          top: isActive ? 22 : 48,
                          bottom: isActive ? 0 : 50,
                        ),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: isActive ? 0.94 : 0.86, end: isActive ? 1.0 : 0.88),
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOut,
                          builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 250),
                            opacity: isActive ? 1 : 0.45,
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  bottom: 36,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 320),
                                    width: isActive ? 210 : 170,
                                    height: isActive ? 210 : 170,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: item.accentColor.withValues(alpha: isActive ? 0.18 : 0.07),
                                      boxShadow: [BoxShadow(color: item.accentColor.withValues(alpha: isActive ? 0.38 : 0.10), blurRadius: 60, spreadRadius: 14)],
                                    ),
                                  ),
                                ),
                                AnimatedScale(
                                  duration: const Duration(milliseconds: 320),
                                  scale: isActive ? 1.0 : 0.88,
                                  child: Image.asset(
                                    item.imagePath,
                                    fit: BoxFit.contain,
                                    height: isActive ? 320 : 260,
                                    errorBuilder: (_, __, ___) => Icon(Icons.coffee, color: Colors.white.withValues(alpha: 0.3), size: 80),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Page dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_featured.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _currentIndex ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == _currentIndex ? _current.accentColor : Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  )),
                ),

                const SizedBox(height: 12),

                // Info
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  child: Padding(
                    key: ValueKey(_current.name),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_current.name, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900)),
                            const SizedBox(width: 10),
                            Text(_current.nameAr, style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 18, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(_current.subtitle, style: TextStyle(color: _current.accentColor, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.8)),
                        const SizedBox(height: 8),
                        Text(_current.description, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13, height: 1.45)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Price / Rating
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: _InfoBox(icon: Icons.local_cafe_rounded, title: 'Price', value: '${_current.price.toStringAsFixed(1)} JD')),
                            const SizedBox(width: 10),
                            Expanded(child: _InfoBox(icon: Icons.star_rounded, title: 'Rating', value: '${_current.rating}')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // CTA row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final mi = kMenuItems.firstWhere(
                            (m) => m.nameEn == _current.name,
                            orElse: () => kMenuItems.first,
                          );
                          widget.cart.add(mi);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: const Color(0xFF1A1A1A),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            content: Text('${_current.name} added to cart', style: const TextStyle(color: Colors.white)),
                          ));
                        },
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                          ),
                          child: const Icon(Icons.add_shopping_cart_rounded, color: Colors.white, size: 22),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => widget.onNavigate(1),
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: _accent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Text('Browse Full Menu', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w900)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Promo banner carousel
                SizedBox(
                  height: 72,
                  child: PageView.builder(
                    controller: _bannerController,
                    itemCount: _promos.length,
                    onPageChanged: (i) => setState(() => _bannerIndex = i),
                    itemBuilder: (ctx, i) {
                      final p = _promos[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: p.colors, begin: Alignment.centerLeft, end: Alignment.centerRight),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: p.accent.withValues(alpha: 0.2)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: p.accent.withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(p.icon, color: p.accent, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: p.accent.withValues(alpha: 0.2),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(p.label, style: TextStyle(color: p.accent, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(p.labelAr, style: TextStyle(color: p.accent.withValues(alpha: 0.5), fontSize: 10)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(p.title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                                      Text(p.sub, style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right_rounded, color: p.accent.withValues(alpha: 0.5), size: 18),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 4),

                // Banner dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_promos.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: i == _bannerIndex ? 12 : 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: i == _bannerIndex ? _promos[i].accent : Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )),
                ),

                const SizedBox(height: 10),

                // Category quick scroll
                SizedBox(
                  height: 36,
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
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          child: Row(
                            children: [
                              Icon(cat.icon, color: Colors.white.withValues(alpha: 0.7), size: 14),
                              const SizedBox(width: 6),
                              Text(cat.nameEn, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoItem {
  final String label, labelAr, title, sub;
  final IconData icon;
  final List<Color> colors;
  final Color accent;

  const _PromoItem({
    required this.label,
    required this.labelAr,
    required this.title,
    required this.sub,
    required this.icon,
    required this.colors,
    required this.accent,
  });
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String title, value;
  const _InfoBox({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 15),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 10, fontWeight: FontWeight.w600)),
              const SizedBox(height: 1),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedGlow extends StatelessWidget {
  final Color color;
  const _AnimatedGlow({required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: -80, right: -50, child: _BlurCircle(size: 280, color: color.withValues(alpha: 0.32))),
        Positioned(bottom: -100, left: -50, child: _BlurCircle(size: 320, color: color.withValues(alpha: 0.22))),
      ],
    );
  }
}

class _BlurCircle extends StatelessWidget {
  final double size;
  final Color color;
  const _BlurCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
      child: Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    );
  }
}

class _FeaturedItem {
  final String name, nameAr, subtitle, imagePath, description;
  final double price, rating;
  final Color accentColor;
  final List<Color> gradient;

  const _FeaturedItem({
    required this.name,
    required this.nameAr,
    required this.subtitle,
    required this.imagePath,
    required this.description,
    required this.price,
    required this.rating,
    required this.accentColor,
    required this.gradient,
  });
}
