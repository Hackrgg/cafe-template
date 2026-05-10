import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/menu_data.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const BLKApp());
}

class BLKApp extends StatelessWidget {
  const BLKApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLK قهوة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        colorScheme: ColorScheme.dark(
          surface: const Color(0xFF141414),
          primary: const Color(0xFFF5F0E8),
        ),
      ),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _surface = Color(0xFF141414);

  int _tab = 0;
  final CartController _cart = CartController();

  void _goTo(int tab) => setState(() => _tab = tab);

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    final screens = [
      HomeScreen(cart: _cart, onNavigate: _goTo),
      MenuScreen(cart: _cart),
      CartScreen(cart: _cart),
      const WalletScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: _bg,
      body: IndexedStack(index: _tab, children: screens),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return ListenableBuilder(
      listenable: _cart,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            color: _surface,
            border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.06))),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 64,
              child: Row(
                children: [
                  _NavItem(icon: Icons.home_rounded, label: 'Home', selected: _tab == 0, onTap: () => _goTo(0)),
                  _NavItem(icon: Icons.menu_book_rounded, label: 'Menu', selected: _tab == 1, onTap: () => _goTo(1)),
                  _CartNavItem(count: _cart.totalItems, selected: _tab == 2, onTap: () => _goTo(2)),
                  _NavItem(icon: Icons.account_balance_wallet_outlined, label: 'Wallet', selected: _tab == 3, onTap: () => _goTo(3)),
                  _NavItem(icon: Icons.person_outline_rounded, label: 'Profile', selected: _tab == 4, onTap: () => _goTo(4)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const Color _accent = Color(0xFFF5F0E8);
  static const Color _grey = Color(0xFF555555);

  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? _accent : _grey, size: 24),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: selected ? _accent : _grey, fontSize: 10, fontWeight: selected ? FontWeight.w700 : FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

class _CartNavItem extends StatelessWidget {
  final int count;
  final bool selected;
  final VoidCallback onTap;

  static const Color _accent = Color(0xFFF5F0E8);
  static const Color _grey = Color(0xFF555555);

  const _CartNavItem({required this.count, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.shopping_bag_outlined, color: selected ? _accent : _grey, size: 24),
                if (count > 0)
                  Positioned(
                    right: -8,
                    top: -6,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
                      child: Center(
                        child: Text('$count', style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Cart', style: TextStyle(color: selected ? _accent : _grey, fontSize: 10, fontWeight: selected ? FontWeight.w700 : FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
