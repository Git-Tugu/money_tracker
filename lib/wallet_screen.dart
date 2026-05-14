import 'package:flutter/material.dart';
import 'colors.dart';
import 'homepage.dart';
import 'connect_wallet.dart';
import 'add_expense.dart';
import 'bill_details.dart';

class WalletScreen extends StatefulWidget {
  final bool showPending;
  const WalletScreen({super.key, this.showPending = false});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late bool isTransactionsSelected;

  @override
  void initState() {
    super.initState();
    isTransactionsSelected = !widget.showPending;
  }

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
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
                              transitionDuration: Duration.zero,
                            ),
                          );
                        }
                      },
                    ),
                    const Text(
                      'Түрийвч',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
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
                              size: 26,
                            ),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: CircleAvatar(
                                radius: 4,
                                backgroundColor: AppColors.accentOrange,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              
              // White content area
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          const Text(
                            'Нийт үлдэгдэл',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '\$ 2,548.00',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 35),
                          
                          // Circular Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCircleAction(Icons.add, 'Нэмэх', () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const ConnectWalletScreen(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(0.0, 1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeOut;
                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }),
                              const SizedBox(width: 50),
                              _buildCircleAction(Icons.grid_view_rounded, 'Төлбөр', () async {
                                final result = await Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const AddExpenseScreen(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(0.0, 1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeOut;
                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                                if (result == true) {
                                  setState(() {
                                    isTransactionsSelected = false;
                                  });
                                }
                              }),
                            ],
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Custom Toggle switch
                          _buildToggle(),
                          
                          const SizedBox(height: 25),
                          
                          // Transaction List or Pending List
                          isTransactionsSelected 
                            ? _buildTransactionsList() 
                            : _buildPendingList(),
                          
                          const SizedBox(height: 100), // Bottom padding
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCircleAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
            ),
            child: Icon(icon, color: AppColors.primaryJadeHeavy, size: 32),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF444444),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            alignment: isTransactionsSelected ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.43,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isTransactionsSelected = true),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Text(
                      'Гүйлгээнүүд',
                      style: TextStyle(
                        color: isTransactionsSelected ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isTransactionsSelected = false),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Хүлээгдэж буй гүйлгээ',
                      style: TextStyle(
                        color: !isTransactionsSelected ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    final transactions = [
      {'title': 'Upwork', 'sub': 'Today', 'amount': '+ \$ 850.00', 'isPos': true, 'img': Icons.work_outline},
      {'title': 'Transfer', 'sub': 'Yesterday', 'amount': '- \$ 85.00', 'isPos': false, 'img': Icons.person_outline},
      {'title': 'Paypal', 'sub': 'Jan 30, 2022', 'amount': '+ \$ 1,406.00', 'isPos': true, 'img': Icons.payment},
      {'title': 'Youtube', 'sub': 'Jan 16, 2022', 'amount': '- \$ 11.99', 'isPos': false, 'img': Icons.play_arrow_outlined},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final item = transactions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F6F5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(item['img'] as IconData, color: AppColors.primaryJadeHeavy, size: 28),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      item['sub'] as String,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Text(
                item['amount'] as String,
                style: TextStyle(
                  color: (item['isPos'] as bool) ? const Color(0xFF25A969) : const Color(0xFFF95B51),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPendingList() {
    final pending = [
      {'title': 'Youtube', 'sub': 'Feb 28, 2022', 'img': Icons.play_arrow_outlined},
      {'title': 'Electricity', 'sub': 'Mar 28, 2022', 'img': Icons.flash_on_outlined},
      {'title': 'House Rent', 'sub': 'Mar 31, 2022', 'img': Icons.home_outlined},
      {'title': 'Spotify', 'sub': 'Feb 28, 2022', 'img': Icons.music_note_outlined},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pending.length,
      itemBuilder: (context, index) {
        final item = pending[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F6F5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(item['img'] as IconData, color: AppColors.primaryJadeHeavy, size: 28),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      item['sub'] as String,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillDetails(
                        title: item['title'] as String,
                        date: item['sub'] as String,
                        icon: item['img'] as IconData,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECF9F8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Төлөх',
                    style: TextStyle(
                      color: AppColors.primaryJadeHeavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
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
          _buildNavItem(Icons.home_outlined, false, () {
             Navigator.of(context).pushReplacement(
               PageRouteBuilder(
                 pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
                 transitionDuration: Duration.zero,
               ),
             );
          }),
          _buildNavItem(Icons.bar_chart_outlined, false, () {}),
          _buildNavItem(Icons.account_balance_wallet, true, () {}),
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
        color: isActive ? AppColors.primaryJadeHeavy : const Color(0xFFAAAAAA),
      ),
    );
  }
}
