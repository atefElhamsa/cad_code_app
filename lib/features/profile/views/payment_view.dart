import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/brand_header.dart';
import '../widgets/number_card.dart';
import '../widgets/payment_method_tile.dart';

enum _PaymentMethod { instapay, vodafoneCash }

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  static const String _instapayNumber = '01552946586';
  static const String _vodafoneCashNumber = '01272442829';

  _PaymentMethod _selected = _PaymentMethod.instapay;

  String get _selectedNumber => _selected == _PaymentMethod.instapay
      ? _instapayNumber
      : _vodafoneCashNumber;

  String get _selectedLabel =>
      _selected == _PaymentMethod.instapay ? 'InstaPay' : 'Vodafone Cash';

  Future<void> _copyNumber() async {
    await Clipboard.setData(ClipboardData(text: _selectedNumber));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_selectedLabel number copied!',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.primaryCyan,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleFontSize = ResponsiveUtils.fontSize(
      context,
      18,
      minScale: 1.0,
      maxScale: 1.15,
    );
    final descFontSize = ResponsiveUtils.fontSize(
      context,
      14,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          BrandHeader(
            title: 'Payment',
            showBack: true,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: ResponsiveConstraint(
                tabletMaxWidth: 680,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                          'Choose a transfer method',
                          style: TextStyle(
                            color: AppTheme.textDarkNavy,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Inter',
                          ),
                        )
                        .animate()
                        .fade(duration: 400.ms)
                        .slideY(begin: 0.1, curve: Curves.easeOutQuad),
                    const SizedBox(height: 8),
                    Text(
                          'Send the course amount, then share your receipt on WhatsApp.',
                          style: TextStyle(
                            color: AppTheme.textGray,
                            fontSize: descFontSize,
                            fontFamily: 'Inter',
                            height: 1.5,
                          ),
                        )
                        .animate()
                        .fade(duration: 400.ms, delay: 80.ms)
                        .slideY(begin: 0.1, curve: Curves.easeOutQuad),
                    const SizedBox(height: 24),
                    PaymentMethodTile(
                          title: 'InstaPay',
                          subtitle: 'Instant bank transfer',
                          accentColor: const Color(0xFF5A2C82),
                          isSelected: _selected == _PaymentMethod.instapay,
                          image: Image.asset(
                            'assets/images/InstaPay_Logo.png',
                            fit: BoxFit.contain,
                          ),
                          onTap: () => setState(
                            () => _selected = _PaymentMethod.instapay,
                          ),
                        )
                        .animate()
                        .fade(duration: 400.ms, delay: 120.ms)
                        .slideY(begin: 0.1, curve: Curves.easeOutQuad),
                    const SizedBox(height: 12),
                    PaymentMethodTile(
                          title: 'Vodafone Cash',
                          subtitle: 'Mobile wallet transfer',
                          accentColor: const Color(0xFFE60000),
                          isSelected: _selected == _PaymentMethod.vodafoneCash,
                          image: Image.asset(
                            'assets/images/vodafone_cash_logo.png',
                            fit: BoxFit.contain,
                          ),
                          onTap: () => setState(
                            () => _selected = _PaymentMethod.vodafoneCash,
                          ),
                        )
                        .animate()
                        .fade(duration: 400.ms, delay: 180.ms)
                        .slideY(begin: 0.1, curve: Curves.easeOutQuad),
                    const SizedBox(height: 28),
                    Text(
                      'Transfer to $_selectedLabel',
                      style: TextStyle(
                        color: AppTheme.textGray,
                        fontSize: ResponsiveUtils.fontSize(context, 13),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    NumberCard(
                          number: _selectedNumber,
                          onCopy: _copyNumber,
                          icon: _selected == _PaymentMethod.instapay
                              ? Image.asset(
                                  'assets/images/InstaPay_Logo.png',
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  'assets/images/vodafone_cash_logo.png',
                                  fit: BoxFit.contain,
                                ),
                        )
                        .animate(key: ValueKey(_selectedNumber))
                        .fade(duration: 250.ms)
                        .slideY(begin: 0.08, curve: Curves.easeOutQuad),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
