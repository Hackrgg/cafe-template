import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLK قهوة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const CoffeeSelectionPage(),
    );
  }
}

class CoffeeSelectionPage extends StatefulWidget {
  const CoffeeSelectionPage({super.key});

  @override
  State<CoffeeSelectionPage> createState() => _CoffeeSelectionPageState();
}

class _CoffeeSelectionPageState extends State<CoffeeSelectionPage> {
  late final PageController _pageController;

  static const Color _accent = Color(0xFFF5F0E8);

  final List<CoffeeItem> _items = const [
    CoffeeItem(
      name: 'Mocha',
      subtitle: 'Chocolate & creamy',
      imagePath: 'assets/images/mocha.png',
      description:
          'Rich espresso mixed with smooth milk and deep chocolate notes.',
      price: 3,
      rating: 4.8,
      gradient: [
        Color(0xFF0A0A0A),
        Color(0xFF1A1210),
        Color(0xFF2E1F18),
      ],
    ),
    CoffeeItem(
      name: 'Espresso',
      subtitle: 'Strong & bold',
      imagePath: 'assets/images/expresso.png',
      description:
          'Pure and intense coffee taste for those who love a sharp energy kick.',
      price: 5,
      rating: 4.9,
      gradient: [
        Color(0xFF0A0A0A),
        Color(0xFF130E0C),
        Color(0xFF221710),
      ],
    ),
    CoffeeItem(
      name: 'Latte',
      subtitle: 'Soft & milky',
      imagePath: 'assets/images/latte.png',
      description:
          'A softer coffee experience with silky steamed milk and balanced taste.',
      price: 4,
      rating: 4.7,
      gradient: [
        Color(0xFF0A0A0A),
        Color(0xFF17120F),
        Color(0xFF2A1F18),
      ],
    ),
  ];

  int _currentIndex = 0;
  String _selectedSize = 'Medium';

  final List<String> _sizes = const ['Small', 'Medium', 'Large'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.82,
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  CoffeeItem get currentItem => _items[_currentIndex];

  @override
  Widget build(BuildContext context) {
    final item = currentItem;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: item.gradient,
          ),
        ),
        child: Stack(
          children: [
            _AnimatedBackgroundGlow(color: _accent),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.10),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/images/blk_logo.png',
                          height: 48,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.10),
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'What would you like today?',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Expanded(
                    flex: 11,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _items.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final coffee = _items[index];
                        final isActive = index == _currentIndex;

                        return AnimatedPadding(
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOut,
                          padding: EdgeInsets.only(
                            left: 6,
                            right: 6,
                            top: isActive ? 22 : 48,
                            bottom: isActive ? 0 : 50,
                          ),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(
                              begin: isActive ? 0.94 : 0.86,
                              end: isActive ? 1.0 : 0.88,
                            ),
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.easeOut,
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: child,
                              );
                            },
                            child: _CoffeeSlideItem(
                              coffee: coffee,
                              isActive: isActive,
                              accent: _accent,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 2),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    child: Padding(
                      key: ValueKey(item.name),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.45),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.55),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: _sizes.map((size) {
                        final selected = size == _selectedSize;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedSize = size;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? _accent
                                      : Colors.white.withValues(alpha: 0.07),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: selected
                                        ? _accent
                                        : Colors.white.withValues(alpha: 0.10),
                                  ),
                                  boxShadow: selected
                                      ? [
                                          BoxShadow(
                                            color: _accent.withValues(alpha: 0.20),
                                            blurRadius: 18,
                                            spreadRadius: 1,
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Text(
                                  size,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.black
                                        : Colors.white.withValues(alpha: 0.6),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _InfoBox(
                                  icon: Icons.local_cafe_rounded,
                                  title: 'Price',
                                  value: '₺${item.price}',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _InfoBox(
                                  icon: Icons.star_rounded,
                                  title: 'Score',
                                  value: '${item.rating}',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: const Color(0xFF1A1A1A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            content: Text(
                              '${item.name} · $_selectedSize added to order',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: _accent,
                          boxShadow: [
                            BoxShadow(
                              color: _accent.withValues(alpha: 0.20),
                              blurRadius: 22,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Text(
                          'Order Now',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoffeeSlideItem extends StatelessWidget {
  final CoffeeItem coffee;
  final bool isActive;
  final Color accent;

  const _CoffeeSlideItem({
    required this.coffee,
    required this.isActive,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
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
                  color: Colors.white.withValues(alpha: isActive ? 0.05 : 0.02),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: isActive ? 0.08 : 0.03),
                      blurRadius: 60,
                      spreadRadius: 12,
                    ),
                  ],
                ),
              ),
            ),

            AnimatedScale(
              duration: const Duration(milliseconds: 320),
              scale: isActive ? 1.0 : 0.88,
              child: Image.asset(
                coffee.imagePath,
                fit: BoxFit.contain,
                height: isActive ? 360 : 290,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'Image not found',
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoBox({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.black.withValues(alpha: 0.20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.6), size: 16),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.40),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackgroundGlow extends StatelessWidget {
  final Color color;

  const _AnimatedBackgroundGlow({required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -90,
          right: -60,
          child: _BlurCircle(
            size: 220,
            color: color.withValues(alpha: 0.06),
          ),
        ),
        Positioned(
          bottom: -120,
          left: -60,
          child: _BlurCircle(
            size: 260,
            color: color.withValues(alpha: 0.05),
          ),
        ),
        Positioned(
          top: 250,
          left: 50,
          child: _BlurCircle(
            size: 120,
            color: Colors.white.withValues(alpha: 0.03),
          ),
        ),
      ],
    );
  }
}

class _BlurCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class CoffeeItem {
  final String name;
  final String subtitle;
  final String imagePath;
  final String description;
  final int price;
  final double rating;
  final List<Color> gradient;

  const CoffeeItem({
    required this.name,
    required this.subtitle,
    required this.imagePath,
    required this.description,
    required this.price,
    required this.rating,
    required this.gradient,
  });
}
