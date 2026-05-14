import 'package:flutter/material.dart';
import 'colors.dart';
import 'homepage.dart';
import 'wallet_screen.dart';

class ConnectWalletScreen extends StatefulWidget {
  const ConnectWalletScreen({super.key});

  @override
  State<ConnectWalletScreen> createState() => _ConnectWalletScreenState();
}

class _ConnectWalletScreenState extends State<ConnectWalletScreen> {
  bool isCardsSelected = false; // Set to false to show the view from the image by default

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
                width: 200,
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
                      'Түрийвчтэй холбох',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
              const SizedBox(height: 20),
              
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
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          
                          // Tabs
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F6F6),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => isCardsSelected = true),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isCardsSelected ? Colors.white : Colors.transparent,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: isCardsSelected ? [
                                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
                                        ] : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Картууд',
                                          style: TextStyle(
                                            color: isCardsSelected ? Colors.black : Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => isCardsSelected = false),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: !isCardsSelected ? Colors.white : Colors.transparent,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: !isCardsSelected ? [
                                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
                                        ] : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Аккаунт',
                                          style: TextStyle(
                                            color: !isCardsSelected ? Colors.black : Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          if (isCardsSelected) _buildCardsTab() else _buildAccountTab(),
                          
                          const SizedBox(height: 120), // Bottom padding
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

  Widget _buildCardsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        // Cards Stack
        Center(
          child: SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(
              children: [
                // Back card
                Positioned(
                  top: 0,
                  left: 40,
                  right: 40,
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6AC6B9), Color(0xFF498E87)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('VISA', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                            Text('Mono', style: TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Front card
                Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 190,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF418C86), Color(0xFF5CA39D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8))
                      ],
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Debit\nCard', style: TextStyle(color: Colors.white, fontSize: 14, height: 1.2)),
                            Text('Mono', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.sim_card_outlined, color: Colors.white70, size: 40),
                        const SizedBox(height: 10),
                        const Text(
                          '6219   8610   2888   8075',
                          style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('IRVAN MOSES', style: TextStyle(color: Colors.white, fontSize: 14)),
                            Text('22/01', style: TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 30),
        const Text(
          'Картны мэдээллээ нэмэх',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
        ),
        const SizedBox(height: 8),
        const Text(
          'Энд холбох карт нь зөвхөн таны нэр дээр байх ёстой.',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 25),
        
        // Form
        _buildTextField('КАРТ ДЭЭРХ НЭР', 'Davaasuren Nyamjav'),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(flex: 2, child: _buildTextField('КАРТЫН ДУГААР', '')),
            const SizedBox(width: 15),
            Expanded(child: _buildTextField('CVC', '')),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(flex: 2, child: _buildTextField('ДУУСАХ ХУГАЦАА YYYY/MM', '')),
            const SizedBox(width: 15),
            Expanded(child: _buildTextField('Value \$', '')),
          ],
        ),
        
        const SizedBox(height: 40),
        
        // Action Button
        SizedBox(
          width: double.infinity,
          height: 60,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryJadeHeavy),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text(
              'ИЛГЭЭХ',
              style: TextStyle(
                color: AppColors.primaryJadeHeavy,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountTab() {
    return Column(
      children: [
        const SizedBox(height: 30),
        _buildConnectionOption(
          icon: Icons.account_balance,
          title: 'Bank Link',
          subtitle: 'Connect your bank\naccount to deposit & fund',
          isSelected: true,
        ),
        const SizedBox(height: 15),
        _buildConnectionOption(
          icon: Icons.monetization_on_outlined,
          title: 'Microdeposits',
          subtitle: 'Connect bank in 5-7 days',
          isSelected: false,
        ),
        const SizedBox(height: 15),
        _buildConnectionOption(
          icon: Icons.paypal_outlined,
          title: 'Paypal',
          subtitle: 'Connect you paypal account',
          isSelected: false,
        ),
        const SizedBox(height: 100),
        // Next Button
        SizedBox(
          width: double.infinity,
          height: 60,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryJadeHeavy),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text(
              'ДАРААХ',
              style: TextStyle(
                color: AppColors.primaryJadeHeavy,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConnectionOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEFF8F7) : const Color(0xFFF9FAFA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF5A918B), size: 30),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5A918B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_circle, color: Color(0xFF5A918B), size: 24),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, color: Color(0xFF444444)),
          ),
        ),
      ],
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
          _buildNavItem(Icons.account_balance_wallet, true, () {
            Navigator.of(context).pushReplacement(
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
        color: isActive ? AppColors.primaryJadeHeavy : const Color(0xFFAAAAAA),
      ),
    );
  }
}
