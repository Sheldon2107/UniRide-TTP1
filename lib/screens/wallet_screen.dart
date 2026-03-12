import 'package:flutter/material.dart';
import 'pick_up_screen.dart'; // Ensure this import exists

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView( // Added scroll view to prevent overflow
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Wallet Section",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // ROADWAY CASH CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Roadway Cash",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Rm20.90",
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              const Text("Topup your cash", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              const Text(
                "Pay with",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              // PAYMENT METHODS - Now passing context
              _paymentMethodTile(
                context: context,
                icon: Icons.credit_card,
                title: "Debit card",
                subtitle: "Accepting Visa, Mastercard, etc",
              ),
              _paymentMethodTile(
                context: context,
                icon: Icons.account_balance_wallet,
                title: "Google Pay",
                isGooglePay: true,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(),
              ),

              const Text("Add manual payments", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              // ADD NEW SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add new",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.add_circle_outline, color: Colors.grey[600]),
                ],
              ),
              const SizedBox(height: 20),

              // MANUAL METHODS - Now passing context
              _manualPaymentTile(context, "Online Banking", Icons.account_balance),
              _manualPaymentTile(context, "Pay with Cash", Icons.money),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for Top Payment Methods (Updated with onTap navigation)
  Widget _paymentMethodTile({
    required BuildContext context, 
    required IconData icon, 
    required String title, 
    String? subtitle, 
    bool isGooglePay = false
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PickUpScreen()),
        );
      },
      leading: Icon(icon, color: isGooglePay ? Colors.blue : Colors.grey[700], size: 28),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12)) : null,
      trailing: const Icon(Icons.add_circle_outline, size: 22, color: Colors.grey),
    );
  }

  // Helper for Manual Payments (Updated with onTap navigation)
  Widget _manualPaymentTile(BuildContext context, String title, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PickUpScreen()),
        );
      },
      leading: Icon(icon, color: Colors.green[700], size: 24),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.qr_code_scanner, size: 22, color: Colors.black87),
    );
  }
}