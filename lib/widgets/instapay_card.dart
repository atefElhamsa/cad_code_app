import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_theme.dart';

class InstapayCard extends StatelessWidget {
  final String instapayNumber;

  const InstapayCard({super.key, required this.instapayNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5A2C82).withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          const Image(
            image: AssetImage('assets/images/InstaPay_Logo.png'),
            width: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 48),
          const Text(
            'Transfer Amount To',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildNumberBadge(context),
        ],
      ),
    );
  }

  Widget _buildNumberBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF5A2C82).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF5A2C82).withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            instapayNumber,
            style: const TextStyle(
              color: Color(0xFF5A2C82),
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              fontFamily: 'Inter',
            ),
          ),
          IconButton(
            onPressed: () => _copyNumber(context),
            icon: const Icon(
              Icons.copy_rounded,
              color: Color(0xFF5A2C82),
              size: 24,
            ),
            tooltip: 'Copy Number',
          ),
        ],
      ),
    );
  }

  void _copyNumber(BuildContext context) {
    Clipboard.setData(ClipboardData(text: instapayNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Number copied!',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryCyan,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
