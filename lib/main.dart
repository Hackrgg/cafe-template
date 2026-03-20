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
      title: 'Coffee Selection',
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

  final List<CoffeeItem> _items = const [
    CoffeeItem(
      name:'Mocha',
      subtitle: 'Chocolate & creamy',
      imagePath: 'assets/images/mocha.png',
      description:
          'Rich espresso mixed with smooth milk and deep chocolate notes.',
      price: 3,
      rating: 4.8,
      accentColor: Color(0xFFFFC46B),
      gradient: [
        Color(0xFF2B1710),
        Color(0xFF5A3421),
        Color(0xFF8C5A36),
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
      accentColor: Color(0xFFFF9A62),
      gradient: [
        Color(0xFF120D0B),
        Color(0xFF3B241B),
        Color(0xFF6D4737),
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
      accentColor: Color(0xFF8ED8FF),
      gradient: [
        Color(0xFF3C241A),
        Color(0xFF8A6A57),
        Color(0xFFD8C2B1),
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
            _AnimatedBackgroundGlow(color: item.accentColor),
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
                            color: Colors.white.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const Spacer(),
                        const Column(
                          children: [
                            Text(
                              'What would you like to drink today?',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Coffee Selection',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.subtitle,
                            style: TextStyle(
                              color: item.accentColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.45,
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
                                      ? item.accentColor
                                      : Colors.white.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: selected
                                      ? [
                                          BoxShadow(
                                            color: item.accentColor
                                                .withOpacity(0.35),
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
                                        ? Colors.black87
                                        : Colors.white,
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
                            color: Colors.white.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
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
                            backgroundColor: Colors.black87,
                            content: Text(
                              '${item.name} - $_selectedSize selected',
                            ),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 280),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          gradient: LinearGradient(
                            colors: [
                              item.accentColor,
                              Colors.white.withOpacity(0.95),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: item.accentColor.withOpacity(0.35),
                              blurRadius: 22,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Text(
                          'Confirm Selection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
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

  const _CoffeeSlideItem({
    required this.coffee,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: isActive ? 1 : 0.55,
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
                  color: coffee.accentColor.withOpacity(isActive ? 0.14 : 0.08),
                  boxShadow: [
                    BoxShadow(
                      color: coffee.accentColor.withOpacity(isActive ? 0.22 : 0.10),
                      blurRadius: 45,
                      spreadRadius: 8,
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
        color: Colors.black.withOpacity(0.14),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
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
            color: color.withOpacity(0.20),
          ),
        ),
        Positioned(
          bottom: -120,
          left: -60,
          child: _BlurCircle(
            size: 260,
            color: color.withOpacity(0.16),
          ),
        ),
        Positioned(
          top:250,
          left:50,
          child: _BlurCircle(
            size:120,
            color: Colors.white.withOpacity(0.05),
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
  final Color accentColor;
  final List<Color> gradient;

  const CoffeeItem({
    required this.name,
    required this.subtitle,
    required this.imagePath,
    required this.description,
    required this.price,
    required this.rating,
    required this.accentColor,
    required this.gradient,
  });
}