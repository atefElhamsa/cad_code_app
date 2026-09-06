import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class PaymentBottomSheet extends StatelessWidget {
  final String methodName;
  final IconData icon;
  final Color iconColor;

  const PaymentBottomSheet({
    super.key,
    required this.methodName,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppTheme.textDarkNavy,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 64),
          const SizedBox(height: 16),
          Text(
            methodName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.backgroundLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '01012345678', // Mock data
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.backgroundLight.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.backgroundLight,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Confirm Payment',
                style: TextStyle(color: AppTheme.textDarkNavy, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
