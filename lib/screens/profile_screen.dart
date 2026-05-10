import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _surface = Color(0xFF141414);
  static const Color _gold = Color(0xFFC9A84C);
  static const Color _grey = Color(0xFF666666);

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildUserCard()),
          SliverToBoxAdapter(child: _buildLoyaltyCard()),
          SliverToBoxAdapter(child: _buildSettings()),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Row(
          children: [
            const Text('Profile', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(width: 8),
            Text('حسابي', style: TextStyle(color: _grey, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF2A2A2A), Color(0xFF1A1A1A)],
                ),
                border: Border.all(color: _gold.withValues(alpha: 0.3)),
              ),
              child: const Center(
                child: Text('A', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ahmed Al-Rashid', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text('+962 7X XXX XXXX', style: TextStyle(color: _grey, fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: _gold.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _gold.withValues(alpha: 0.25)),
                        ),
                        child: const Text('Gold Member', style: TextStyle(color: _gold, fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.edit_outlined, color: _grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLoyaltyCard() {
    const stampsEarned = 7;
    const stampsTotal = 10;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1408), Color(0xFF2A200C), Color(0xFF151008)],
          ),
          border: Border.all(color: _gold.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Loyalty Card', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 2),
                    Text('بطاقة الولاء', style: TextStyle(color: _gold.withValues(alpha: 0.6), fontSize: 12)),
                  ],
                ),
                const Spacer(),
                Image.asset('assets/images/blk_logo.png', height: 32, color: _gold.withValues(alpha: 0.6)),
              ],
            ),
            const SizedBox(height: 6),
            Text('$stampsEarned/$stampsTotal stamps — 3 more until your free drink!',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 12, height: 1.4)),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: stampsTotal,
              itemBuilder: (_, i) {
                final filled = i < stampsEarned;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? _gold.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.04),
                    border: Border.all(
                      color: filled ? _gold : Colors.white.withValues(alpha: 0.12),
                      width: filled ? 1.5 : 1,
                    ),
                  ),
                  child: filled
                      ? const Icon(Icons.coffee, color: _gold, size: 18)
                      : null,
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _gold.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_rounded, color: _gold, size: 16),
                  const SizedBox(width: 6),
                  Text('Redeem free drink at 10 stamps', style: TextStyle(color: _gold.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Settings', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          _SettingsGroup(items: [
            _SettingsItem(icon: Icons.notifications_outlined, label: 'Notifications', sub: 'Offers & order updates'),
            _SettingsItem(icon: Icons.location_on_outlined, label: 'Saved Addresses', sub: '2 saved locations'),
            _SettingsItem(icon: Icons.language_rounded, label: 'Language', sub: 'English / العربية'),
          ]),
          const SizedBox(height: 16),
          _SettingsGroup(items: [
            _SettingsItem(icon: Icons.help_outline_rounded, label: 'Help & Support', sub: 'Chat or call us'),
            _SettingsItem(icon: Icons.privacy_tip_outlined, label: 'Privacy Policy', sub: ''),
            _SettingsItem(icon: Icons.info_outline_rounded, label: 'About BLK', sub: 'Version 1.0.0'),
          ]),
          const SizedBox(height: 16),
          _SettingsGroup(items: [
            _SettingsItem(icon: Icons.logout_rounded, label: 'Sign Out', sub: '', danger: true),
          ]),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<_SettingsItem> items;
  static const Color _surface = Color(0xFF141414);

  const _SettingsGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final isLast = e.key == items.length - 1;
          return Column(
            children: [
              e.value,
              if (!isLast) const Divider(height: 1, color: Color(0xFF1E1E1E), indent: 52),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label, sub;
  final bool danger;

  static const Color _grey = Color(0xFF666666);

  const _SettingsItem({required this.icon, required this.label, required this.sub, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: danger ? Colors.red.shade400 : _grey, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: danger ? Colors.red.shade400 : Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                if (sub.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(sub, style: const TextStyle(color: _grey, fontSize: 12)),
                ],
              ],
            ),
          ),
          if (!danger) Icon(Icons.chevron_right_rounded, color: _grey, size: 18),
        ],
      ),
    );
  }
}
