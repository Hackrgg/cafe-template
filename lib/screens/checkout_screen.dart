import 'package:flutter/material.dart';
import '../models/menu_data.dart';

class CheckoutScreen extends StatefulWidget {
  final CartController cart;

  const CheckoutScreen({super.key, required this.cart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);
  static const Color _grey = Color(0xFF666666);
  static const Color _gold = Color(0xFFC9A84C);

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  String _delivery = 'delivery';
  String _payment = 'wallet';
  bool _placing = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    setState(() => _placing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    widget.cart.clear();
    setState(() => _placing = false);
    _showSuccess();
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(color: Color(0xFF1A2A1A), shape: BoxShape.circle),
              child: const Icon(Icons.check_rounded, color: Color(0xFF4CAF50), size: 36),
            ),
            const SizedBox(height: 16),
            const Text('Order Placed!', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text('Your order is being prepared.\nEstimated delivery: 25–35 min', textAlign: TextAlign.center, style: TextStyle(color: _grey, fontSize: 13, height: 1.5)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
                child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: _surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withValues(alpha: 0.08))),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _sectionLabel('Delivery Method', 'طريقة الاستلام'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _DeliveryToggle(label: 'Delivery', labelAr: 'توصيل', icon: Icons.delivery_dining_rounded, selected: _delivery == 'delivery', onTap: () => setState(() => _delivery = 'delivery')),
                      const SizedBox(width: 12),
                      _DeliveryToggle(label: 'Pickup', labelAr: 'استلام', icon: Icons.store_rounded, selected: _delivery == 'pickup', onTap: () => setState(() => _delivery = 'pickup')),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _sectionLabel('Your Details', 'بياناتك'),
                  const SizedBox(height: 12),
                  _field(_nameCtrl, 'Full Name', 'الاسم الكامل', Icons.person_outline_rounded),
                  const SizedBox(height: 12),
                  _field(_phoneCtrl, 'Phone Number', 'رقم الهاتف', Icons.phone_outlined, type: TextInputType.phone),
                  if (_delivery == 'delivery') ...[
                    const SizedBox(height: 12),
                    _field(_addressCtrl, 'Delivery Address', 'عنوان التوصيل', Icons.location_on_outlined, maxLines: 2),
                  ],
                  const SizedBox(height: 12),
                  _field(_notesCtrl, 'Special Notes (optional)', 'ملاحظات خاصة', Icons.notes_rounded, maxLines: 2),
                  const SizedBox(height: 24),
                  _sectionLabel('Payment Method', 'طريقة الدفع'),
                  const SizedBox(height: 12),
                  _PaymentOption(icon: Icons.account_balance_wallet_outlined, label: 'BLK Wallet', sub: 'Balance: 24.50 JD', selected: _payment == 'wallet', onTap: () => setState(() => _payment = 'wallet'), accent: _gold),
                  const SizedBox(height: 10),
                  _PaymentOption(icon: Icons.credit_card_rounded, label: 'Credit / Debit Card', sub: 'Visa, Mastercard', selected: _payment == 'card', onTap: () => setState(() => _payment = 'card'), accent: _accent),
                  const SizedBox(height: 10),
                  _PaymentOption(icon: Icons.payments_outlined, label: 'Cash on Delivery', sub: 'Pay when you receive', selected: _payment == 'cash', onTap: () => setState(() => _payment = 'cash'), accent: _accent),
                  const SizedBox(height: 24),
                  _sectionLabel('Order Summary', 'ملخص الطلب'),
                  const SizedBox(height: 12),
                  ListenableBuilder(
                    listenable: widget.cart,
                    builder: (_, __) => Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: _surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withValues(alpha: 0.06))),
                      child: Column(
                        children: [
                          ...widget.cart.items.map((ci) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Text('${ci.quantity}×', style: TextStyle(color: _grey, fontSize: 13)),
                                const SizedBox(width: 8),
                                Expanded(child: Text(ci.item.nameEn, style: const TextStyle(color: Colors.white, fontSize: 13))),
                                Text('${ci.totalPrice.toStringAsFixed(1)} JD', style: const TextStyle(color: _accent, fontSize: 13, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          )),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(color: Color(0xFF2A2A2A)),
                          ),
                          Row(
                            children: [
                              Text('Subtotal', style: TextStyle(color: _grey, fontSize: 13)),
                              const Spacer(),
                              Text('${widget.cart.totalPrice.toStringAsFixed(2)} JD', style: const TextStyle(color: Colors.white, fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text('Delivery', style: TextStyle(color: _grey, fontSize: 13)),
                              const Spacer(),
                              Text(_delivery == 'pickup' ? 'Free' : '1.50 JD', style: TextStyle(color: _delivery == 'pickup' ? const Color(0xFF4CAF50) : Colors.white, fontSize: 13)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(color: Color(0xFF2A2A2A)),
                          ),
                          Row(
                            children: [
                              const Text('Total', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                              const Spacer(),
                              Text('${(widget.cart.totalPrice + (_delivery == 'delivery' ? 1.5 : 0)).toStringAsFixed(2)} JD', style: const TextStyle(color: _accent, fontSize: 15, fontWeight: FontWeight.w800)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: BoxDecoration(
          color: _bg,
          border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.06))),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _accent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            onPressed: _placing ? null : _placeOrder,
            child: _placing
                ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                : const Text('Place Order', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String en, String ar) {
    return Row(
      children: [
        Text(en, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        Text(ar, style: const TextStyle(color: Color(0xFF666666), fontSize: 13)),
      ],
    );
  }

  Widget _field(TextEditingController ctrl, String hint, String hintAr, IconData icon, {int maxLines = 1, TextInputType type = TextInputType.text}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: type,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: '$hint / $hintAr',
        hintStyle: const TextStyle(color: Color(0xFF444444), fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFF444444), size: 20),
        filled: true,
        fillColor: _surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFF5F0E8))),
      ),
    );
  }
}

class _DeliveryToggle extends StatelessWidget {
  final String label, labelAr;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  static const Color _surface = Color(0xFF141414);
  static const Color _accent = Color(0xFFF5F0E8);

  const _DeliveryToggle({required this.label, required this.labelAr, required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected ? _accent.withValues(alpha: 0.1) : _surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: selected ? _accent : Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            children: [
              Icon(icon, color: selected ? _accent : const Color(0xFF666666), size: 24),
              const SizedBox(height: 6),
              Text(label, style: TextStyle(color: selected ? _accent : Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
              Text(labelAr, style: const TextStyle(color: Color(0xFF666666), fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label, sub;
  final bool selected;
  final VoidCallback onTap;
  final Color accent;

  static const Color _surface = Color(0xFF141414);

  const _PaymentOption({required this.icon, required this.label, required this.sub, required this.selected, required this.onTap, required this.accent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.08) : _surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? accent : Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? accent : const Color(0xFF666666), size: 22),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: selected ? Colors.white : const Color(0xFF999999), fontSize: 14, fontWeight: FontWeight.w600)),
                Text(sub, style: const TextStyle(color: Color(0xFF666666), fontSize: 12)),
              ],
            ),
            const Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: selected ? accent : const Color(0xFF444444), width: 2),
                color: selected ? accent : Colors.transparent,
              ),
              child: selected ? const Icon(Icons.check, size: 12, color: Colors.black) : null,
            ),
          ],
        ),
      ),
    );
  }
}
