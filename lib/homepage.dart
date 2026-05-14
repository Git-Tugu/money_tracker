import 'package:flutter/material.dart';
import 'colors.dart';
import 'wallet_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Transaction History Layer (Scrollable)
          _buildScrollingHistory(),

          // 2. Dashboard Layer (Fixed at top)
          _buildFixedDashboard(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildFixedDashboard() {
    return SizedBox(
      height: 400,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 280,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/top_background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/images/decorator2.png',
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Өглөөний мэнд?',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Н.Даваа',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Stack(
                              children: [
                                Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                Positioned(
                                  right: 2,
                                  top: 2,
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor: AppColors.accentOrange,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 160,
            left: 20,
            right: 20,
            child: _buildBalanceCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollingHistory() {
    final transactions = [
      {
        'title': 'Upwork',
        'subtitle': 'Өнөөдөр',
        'amount': '+ \$ 850.00',
        'isIncome': true,
        'icon': Icons.work_outline,
      },
      {
        'title': 'Шилжүүлэг',
        'subtitle': 'Өчигдөр',
        'amount': '- \$ 85.00',
        'isIncome': false,
        'icon': Icons.person_outline,
      },
      {
        'title': 'Paypal',
        'subtitle': 'Jan 30, 2022',
        'amount': '+ \$ 1,406.00',
        'isIncome': true,
        'icon': Icons.payment,
      },
      {
        'title': 'Youtube',
        'subtitle': 'Jan 16, 2022',
        'amount': '- \$ 11.99',
        'isIncome': false,
        'icon': Icons.play_arrow_outlined,
      },
      {
        'title': 'Netflix',
        'subtitle': 'Jan 15, 2022',
        'amount': '- \$ 15.99',
        'isIncome': false,
        'icon': Icons.movie_outlined,
      },
      {
        'title': 'Salary',
        'subtitle': 'Jan 10, 2022',
        'amount': '+ \$ 5,000.00',
        'isIncome': true,
        'icon': Icons.account_balance_wallet_outlined,
      },
      {
        'title': 'Apple Store',
        'subtitle': 'Jan 05, 2022',
        'amount': '- \$ 99.00',
        'isIncome': false,
        'icon': Icons.laptop_mac,
      },
      {
        'title': 'Amazon',
        'subtitle': 'Jan 02, 2022',
        'amount': '- \$ 45.50',
        'isIncome': false,
        'icon': Icons.shopping_bag_outlined,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(top: 380, left: 25, right: 25, bottom: 100),
      itemCount: transactions.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Гүйлгээний Түүх',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Бүгдийг харах',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        }

        final item = transactions[index - 1];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F6F5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: AppColors.primaryJadeHeavy,
                size: 28,
              ),
            ),
            title: Text(
              item['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            subtitle: Text(
              item['subtitle'] as String,
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Text(
              item['amount'] as String,
              style: TextStyle(
                color: (item['isIncome'] as bool) ? const Color(0xFF25A969) : const Color(0xFFF95B51),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2F7E79),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text(
                    'Нийт үлдэгдэл',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.keyboard_arrow_up, color: Colors.white),
                ],
              ),
              const Icon(Icons.more_horiz, color: Colors.white),
            ],
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '\$ 2,548.00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIncomeExpenseRow(
                icon: Icons.arrow_downward,
                label: 'Орлого',
                amount: '\$ 1,840.00',
              ),
              _buildIncomeExpenseRow(
                icon: Icons.arrow_upward,
                label: 'Зарлага',
                amount: '\$ 284.00',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseRow({
    required IconData icon,
    required String label,
    required String amount,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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
          _buildNavItem(Icons.home, true, () {}),
          _buildNavItem(Icons.bar_chart_outlined, false, () {}),
          _buildNavItem(Icons.account_balance_wallet_outlined, false, () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const WalletScreen(),
                transitionDuration: Duration.zero,
              ),
            );
          }),
          _buildNavItem(Icons.person_outline, false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        icon, 
        size: 32, 
        color: isActive ? AppColors.primaryJadeHeavy : const Color(0xFFAAAAAA)
      ),
    );
  }
}
