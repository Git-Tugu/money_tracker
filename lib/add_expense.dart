import 'dart:ui';
import 'package:flutter/material.dart';
import 'colors.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String amount = '48.00';
  String selectedTransaction = 'Netflix';
  DateTime selectedDate = DateTime(2022, 2, 22);
  bool _showNumpad = true;

  String _formatDate(DateTime date) {
    final List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    String dayName = days[date.weekday - 1];
    String monthName = months[date.month - 1];
    return "$dayName, ${date.day} $monthName ${date.year}";
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryJadeHeavy,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _onKeyPress(String key) {
    setState(() {
      if (key == 'back') {
        if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
        }
      } else if (key == '.') {
        if (!amount.contains('.')) {
          amount += '.';
        }
      } else {
        if (amount == '0') {
          amount = key;
        } else {
          amount += key;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryJadeHeavy,
      body: Column(
        children: [
          Expanded(
            child: Stack(
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
                            'Төлбөр нэмэх',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 30),
                            onPressed: () {},
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
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30),
                                
                                // Transaction Name
                                _buildLabel('ГҮЙЛГЭЭНИЙ НЭР'),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFEEEEEE)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'N',
                                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      const Expanded(
                                        child: Text(
                                          'Netflix',
                                          style: TextStyle(fontSize: 16, color: Color(0xFF444444)),
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(height: 25),
                                
                                // Amount
                                _buildLabel('ҮНИЙН ДҮН'),
                                GestureDetector(
                                  onTap: () => setState(() => _showNumpad = true),
                                  child: Container(
                                    height: 55,
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.primaryJadeHeavy.withOpacity(0.5), width: 1.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        const Text(
                                          '\$ ',
                                          style: TextStyle(fontSize: 16, color: Color(0xFF444444), fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            amount,
                                            style: const TextStyle(fontSize: 16, color: Color(0xFF444444), fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 25),
                                
                                // Date
                                _buildLabel('ОГНОО'),
                                GestureDetector(
                                  onTap: () {
                                    setState(() => _showNumpad = false);
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    height: 55,
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFFEEEEEE)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _formatDate(selectedDate),
                                          style: const TextStyle(fontSize: 16, color: Color(0xFF444444)),
                                        ),
                                        const Icon(Icons.calendar_month, color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 35),
                                
                                // Payment Button
                                _buildLabel('ТӨЛБӨР'),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: SizedBox(
                                    height: 60,
                                    width: double.infinity,
                                    child: CustomPaint(
                                      painter: DashedPainter(),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.add, color: Colors.white, size: 16),
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              'Төлбөр нэмэх',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
          ),
          if (_showNumpad) _buildNumpad(),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNumpad() {
    return Container(
      color: const Color(0xFFD1D3D9),
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      child: Column(
        children: [
          _buildNumpadRow(['1', '2', '3']),
          const SizedBox(height: 7),
          _buildNumpadRow(['4', '5', '6']),
          const SizedBox(height: 7),
          _buildNumpadRow(['7', '8', '9']),
          const SizedBox(height: 7),
          _buildNumpadRow(['.', '0', 'back']),
        ],
      ),
    );
  }

  Widget _buildNumpadRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: keys.map((key) => Expanded(child: _buildNumpadKey(key))).toList(),
      ),
    );
  }

  Widget _buildNumpadKey(String key) {
    final Map<String, String> subTexts = {
      '2': 'ABC', '3': 'DEF', '4': 'GHI', '5': 'JKL', '6': 'MNO',
      '7': 'PQRS', '8': 'TUV', '9': 'WXYZ'
    };

    return GestureDetector(
      onTap: () => _onKeyPress(key),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 1,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Center(
          child: key == 'back'
              ? const Icon(Icons.backspace_outlined, size: 24, color: Colors.black)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      key,
                      style: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    if (subTexts.containsKey(key))
                      Text(
                        subTexts[key]!,
                        style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

class DashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 5;

    final RRect rrect = RRect.fromLTRBR(0, 0, size.width, size.height, const Radius.circular(15));
    final Path path = Path()..addRRect(rrect);

    final Path dashPath = Path();
    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
