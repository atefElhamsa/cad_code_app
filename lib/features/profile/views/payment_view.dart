import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../widgets/brand_header.dart';
import '../../../widgets/instapay_card.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    const String instapayNumber = '01552946586';

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
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InstapayCard(instapayNumber: instapayNumber)
                        .animate()
                        .scale(duration: 600.ms, curve: Curves.easeOutBack)
                        .fade(duration: 500.ms),
                    SizedBox(height: 32.h,),
                    Text(
                      'Please transfer the amount to the\nInstaPay number above.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        height: 1.5,
                      ),
                    ).animate().fade(delay: 300.ms).slideY(begin: 0.2),
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
