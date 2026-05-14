import 'package:flutter/material.dart';
import 'colors.dart';
import 'homepage.dart';
import 'wallet_screen.dart';
import 'bill_receipt.dart';

class BillPayment extends StatelessWidget {
  final String title;
  final IconData icon;

  const BillPayment({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryJadeHeavy,
      body: Stack(
        children: [
          // Background Decorators
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/decorator2.png',
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 50),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'Bill Payment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.white, size: 28),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Main Content Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        // Logo / Icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(icon, color: Colors.red, size: 40),
                        ),
                        const SizedBox(height: 30),
                        // Payment description
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                            children: [
                              const TextSpan(text: 'You will pay '),
                              TextSpan(
                                text: title,
                                style: const TextStyle(
                                  color: Color(0xFF589F99),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: '\nfor one month with BCA OneKlik'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        // Price details
                        _buildPriceRow('Үнэ', '\$ 11.99'),
                        const SizedBox(height: 20),
                        _buildPriceRow('Хураамж', '\$ 1.99'),
                        const SizedBox(height: 20),
                        const Divider(color: Color(0xFFEEEEEE), thickness: 1.5),
                        const SizedBox(height: 20),
                        _buildPriceRow('Нийт', '\$ 13.98', isTotal: true),
                        const Spacer(),
                        // Confirm Button
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BillReceipt(title: title),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryJadeHeavy,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Баталгаажуулах',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 17,
            color: isTotal ? Colors.grey[700] : Colors.grey,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home_outlined, false, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }),
          _buildNavItem(context, Icons.bar_chart_outlined, false, () {}),
          _buildNavItem(context, Icons.account_balance_wallet, true, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const WalletScreen()),
            );
          }),
          _buildNavItem(context, Icons.person_outline, false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        icon,
        size: 32,
        color: isActive ? AppColors.primaryJadeHeavy : const Color(0xFFAAAAAA),
      ),
    );
  }
}
