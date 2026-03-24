import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  final double currentBalance;

  const WalletScreen({super.key, required this.currentBalance});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late double _balance;

  static const Color _brandBlue = Color(0xFF004687);

  static const List<_TopUpOption> _topUpOptions = [
    _TopUpOption(label: "RM10",  amount: 10),
    _TopUpOption(label: "RM20",  amount: 20),
    _TopUpOption(label: "RM50",  amount: 50),
  ];

  static const List<_PaymentMethod> _payMethods = [
    _PaymentMethod(icon: Icons.credit_card,      label: "Debit card",   subtitle: "Including Visa, Master card, etc"),
    _PaymentMethod(icon: Icons.g_mobiledata,     label: "Google Pay",   subtitle: null),
  ];

  static const List<_ManualPayment> _manualPayments = [
    _ManualPayment(label: "Online Banking", tag: "DPay"),
    _ManualPayment(label: "Pay with Cash",  tag: "DBD"),
  ];

  @override
  void initState() {
    super.initState();
    _balance = widget.currentBalance;
  }

  void _topUp(double amount) => setState(() => _balance += amount);

  void _confirm() => Navigator.pop(context, _balance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, _balance),
        ),
        title: const Text(
          "Wallet Section",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // ── Roadway Cash balance card ───────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Roadway Cash",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "RM${_balance.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Top up section ──────────────────────────────────────────
            const Text(
              "Topup your cash",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _topUpOptions.map((option) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _topUp(option.amount),
                      child: Text(
                        "+ ${option.label}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // ── Pay with ───────────────────────────────────────────────
            const Text(
              "Pay with",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ..._payMethods.map((method) => _PayMethodTile(method: method)),

            const SizedBox(height: 24),

            // ── Add manual payments ────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add manual payments",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.add_circle_outline,
                    color: _brandBlue, size: 22),
              ],
            ),
            const SizedBox(height: 12),
            ..._manualPayments.map((mp) => _ManualPaymentTile(mp: mp)),

            const SizedBox(height: 32),

            // ── Confirm button ─────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _brandBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _confirm,
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Skip ───────────────────────────────────────────────────
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context, _balance),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _PayMethodTile extends StatelessWidget {
  final _PaymentMethod method;
  const _PayMethodTile({required this.method});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Icon(method.icon, size: 22, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                if (method.subtitle != null)
                  Text(
                    method.subtitle!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
              ],
            ),
          ),
          const Icon(Icons.add_circle_outline, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}

class _ManualPaymentTile extends StatelessWidget {
  final _ManualPayment mp;
  const _ManualPaymentTile({required this.mp});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              mp.tag,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              mp.label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          // QR icon for visual match to Figma
          const Icon(Icons.qr_code_2, color: Colors.grey, size: 22),
        ],
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _TopUpOption {
  final String label;
  final double amount;
  const _TopUpOption({required this.label, required this.amount});
}

class _PaymentMethod {
  final IconData icon;
  final String label;
  final String? subtitle;
  const _PaymentMethod({
    required this.icon,
    required this.label,
    required this.subtitle,
  });
}

class _ManualPayment {
  final String label;
  final String tag;
  const _ManualPayment({required this.label, required this.tag});
}