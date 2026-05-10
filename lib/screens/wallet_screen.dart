import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);
  static const Color _gold = Color(0xFFC9A84C);
  static const Color _grey = Color(0xFF666666);

  const WalletScreen({super.key});

  static const _transactions = [
    _Tx(label: 'Iced Spanish Latte × 2', amount: -10.0, date: 'Today, 10:32 AM'),
    _Tx(label: 'Top up', amount: 30.0, date: 'Yesterday, 2:15 PM'),
    _Tx(label: 'Classic Matcha', amount: -4.5, date: 'May 7, 9:00 AM'),
    _Tx(label: 'Brownie × 2', amount: -5.0, date: 'May 7, 9:00 AM'),
    _Tx(label: 'Top up', amount: 20.0, date: 'May 6, 6:30 PM'),
    _Tx(label: 'Turkish Coffee', amount: -3.0, date: 'May 5, 8:45 AM'),
    _Tx(label: 'Top up', amount: 50.0, date: 'May 3, 12:00 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildBalanceCard()),
          SliverToBoxAdapter(child: _buildActions(context)),
          SliverToBoxAdapter(child: _buildQR()),
          SliverToBoxAdapter(child: _buildTxHeader()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _TxRow(tx: _transactions[i]),
              childCount: _transactions.length,
            ),
          ),
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
            const Text('Wallet', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(width: 8),
            Text('المحفظة', style: TextStyle(color: _grey, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1408), Color(0xFF2A200C), Color(0xFF1A1208)],
          ),
          border: Border.all(color: _gold.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_balance_wallet_outlined, color: _gold, size: 14),
                      const SizedBox(width: 4),
                      const Text('BLK Wallet', style: TextStyle(color: _gold, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const Spacer(),
                Image.asset('assets/images/blk_logo.png', height: 28, color: _gold.withValues(alpha: 0.6)),
              ],
            ),
            const SizedBox(height: 24),
            Text('Available Balance', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13)),
            const SizedBox(height: 6),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('24', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900, height: 1)),
                Text('.50', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 28, fontWeight: FontWeight.w700, height: 1.4)),
                SizedBox(width: 6),
                Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('JD', style: TextStyle(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF2A2A1A)),
            const SizedBox(height: 12),
            Row(
              children: [
                _MiniStat(label: 'This Month', value: '18.50 JD'),
                Container(width: 1, height: 32, color: const Color(0xFF2A2A1A)),
                _MiniStat(label: 'Total Spent', value: '142 JD'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: _ActionBtn(
              icon: Icons.add_rounded,
              label: 'Add Funds',
              labelAr: 'شحن',
              primary: true,
              onTap: () => _showAddFunds(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionBtn(
              icon: Icons.history_rounded,
              label: 'History',
              labelAr: 'السجل',
              primary: false,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionBtn(
              icon: Icons.share_rounded,
              label: 'Transfer',
              labelAr: 'تحويل',
              primary: false,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQR() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: _QRPlaceholder(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('In-Store QR', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('Show this at the counter to pay', style: TextStyle(color: _grey, fontSize: 12, height: 1.4)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _accent.withValues(alpha: 0.2)),
              ),
              child: const Text('Show QR', style: TextStyle(color: _accent, fontSize: 12, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTxHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        children: [
          const Text('Transactions', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(width: 8),
          Text('المعاملات', style: TextStyle(color: _grey, fontSize: 13)),
        ],
      ),
    );
  }

  void _showAddFunds(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141414),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => const _AddFundsSheet(),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label, value;
  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(color: Color(0xFF888888), fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label, labelAr;
  final bool primary;
  final VoidCallback onTap;

  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);

  const _ActionBtn({required this.icon, required this.label, required this.labelAr, required this.primary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: primary ? _accent : _surface,
          borderRadius: BorderRadius.circular(14),
          border: primary ? null : Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Column(
          children: [
            Icon(icon, color: primary ? Colors.black : Colors.white, size: 22),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: primary ? Colors.black : Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _TxRow extends StatelessWidget {
  final _Tx tx;
  static const Color _surface = Color(0xFF141414);

  const _TxRow({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isCredit = tx.amount > 0;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCredit ? const Color(0xFF1A2A1A) : const Color(0xFF1A1A1A),
              shape: BoxShape.circle,
            ),
            child: Icon(isCredit ? Icons.add_rounded : Icons.remove_rounded, color: isCredit ? const Color(0xFF4CAF50) : const Color(0xFF888888), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(tx.date, style: const TextStyle(color: Color(0xFF666666), fontSize: 11)),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : ''}${tx.amount.toStringAsFixed(2)} JD',
            style: TextStyle(color: isCredit ? const Color(0xFF4CAF50) : Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _AddFundsSheet extends StatefulWidget {
  const _AddFundsSheet();
  @override
  State<_AddFundsSheet> createState() => _AddFundsSheetState();
}

class _AddFundsSheetState extends State<_AddFundsSheet> {
  double _selected = 20;
  static const _amounts = [10.0, 20.0, 50.0, 100.0];
  static const _accent = Color(0xFFF5F0E8);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Add Funds', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          Row(
            children: _amounts.map((a) {
              final sel = a == _selected;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selected = a),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: sel ? _accent : const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('${a.toInt()} JD', textAlign: TextAlign.center, style: TextStyle(color: sel ? Colors.black : Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: _accent, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
              onPressed: () => Navigator.pop(context),
              child: Text('Add ${_selected.toInt()} JD', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}

class _QRPlaceholder extends StatelessWidget {
  const _QRPlaceholder();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _QRPainter());
  }
}

class _QRPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.black..style = PaintingStyle.fill;
    final s = size.width / 7;
    final positions = [
      [0,0],[1,0],[2,0],[0,1],[2,1],[0,2],[1,2],[2,2],
      [4,0],[5,0],[6,0],[4,1],[6,1],[4,2],[5,2],[6,2],
      [0,4],[1,4],[2,4],[0,5],[2,5],[0,6],[1,6],[2,6],
      [3,3],[4,4],[5,5],[3,5],[5,3],[6,6],[4,6],[6,4],
    ];
    for (final pos in positions) {
      canvas.drawRect(Rect.fromLTWH(pos[0]*s, pos[1]*s, s*0.85, s*0.85), p);
    }
  }
  @override
  bool shouldRepaint(_) => false;
}

class _Tx {
  final String label, date;
  final double amount;
  const _Tx({required this.label, required this.amount, required this.date});
}
