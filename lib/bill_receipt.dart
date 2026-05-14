import 'package:flutter/material.dart';
import 'colors.dart';
import 'homepage.dart';
import 'wallet_screen.dart';

class BillReceipt extends StatelessWidget {
  final String title;

  const BillReceipt({
    super.key,
    required this.title,
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          'Амжилттай Төлөгдлөө',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF589F99),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Success Icon
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xFF589F99),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 30),
                        ),
                        const SizedBox(height: 30),
                        // Transaction Details Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Гүйлгээний дэлгэрэнгүй',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_up, color: Colors.grey[700]),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildDetailRow('Төлбөрийн хэрэгсэл', 'Дебит Карт'),
                        _buildDetailRow('Төлөв', 'Хийгдсэн', valueColor: const Color(0xFF589F99)),
                        _buildDetailRow('Цаг', '08:15 AM'),
                        _buildDetailRow('Огноо', 'Feb 28, 2022'),
                        _buildDetailRow('Гүйлгээний дугаар', '2092913832472..', hasCopyIcon: true),
                        const SizedBox(height: 10),
                        const Divider(color: Color(0xFFEEEEEE), thickness: 1.5),
                        const SizedBox(height: 10),
                        _buildPriceRow('Үнэ', '\$ 11.99'),
                        _buildPriceRow('Хураамж', '- \$ 1.99'),
                        const Divider(color: Color(0xFFEEEEEE), thickness: 1.5),
                        _buildPriceRow('Нийт', '\$ 13.98', isTotal: true),
                        const SizedBox(height: 30),
                        // QR Code Placeholder
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.qr_code_2, size: 100),
                        ),
                        const SizedBox(height: 40),
                        // Share Receipt Button
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF589F99), width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Share Receipt',
                              style: TextStyle(
                                color: Color(0xFF589F99),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
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

  Widget _buildDetailRow(String label, String value, {Color? valueColor, bool hasCopyIcon = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? Colors.black,
                ),
              ),
              if (hasCopyIcon) ...[
                const SizedBox(width: 8),
                const Icon(Icons.copy_outlined, size: 18, color: Color(0xFF589F99)),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
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
      ),
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
