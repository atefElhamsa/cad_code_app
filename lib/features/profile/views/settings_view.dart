import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/responsive/responsive.dart';
import '../../../widgets/brand_header.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_list_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  Future<void> _launchSocialUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final showTwoColumns = context.screenWidth > 900;

    final accountCard = SettingsCard(
      children: [
        SettingsListTile(
          title: 'Profile',
          iconBuilder: (color) => Icon(
            Icons.person_rounded,
            color: color,
            size: 22,
          ),
          onTap: () => context.push('/profile'),
        ),
        SettingsListTile(
          title: 'Payment',
          iconBuilder: (color) => Icon(
            Icons.payment_rounded,
            color: color,
            size: 22,
          ),
          onTap: () => context.push('/payment'),
        ),
      ],
    );

    final socialCard = SettingsCard(
      children: [
        SettingsListTile(
          title: 'Facebook',
          iconBuilder: (color) => FaIcon(
            FontAwesomeIcons.facebook,
            color: color,
            size: 22,
          ),
          onTap: () => _launchSocialUrl(
            'https://www.facebook.com/share/1FEBzBSYa4/',
          ),
          customColor: const Color(0xFF1877F2),
        ),
        SettingsListTile(
          title: 'WhatsApp',
          iconBuilder: (color) => FaIcon(
            FontAwesomeIcons.whatsapp,
            color: color,
            size: 22,
          ),
          onTap: () => _launchSocialUrl(
            'https://wa.me/201272442829',
          ),
          customColor: const Color(0xFF25D366),
        ),
        SettingsListTile(
          title: 'Instagram',
          iconBuilder: (color) => FaIcon(
            FontAwesomeIcons.instagram,
            color: color,
            size: 22,
          ),
          onTap: () => _launchSocialUrl(
            'https://www.instagram.com/cadcode.academy?utm_source=qr&stkn=NDMybmFqeXZhbDlk',
          ),
          customColor: const Color(0xFFE1306C),
        ),
        SettingsListTile(
          title: 'TikTok',
          iconBuilder: (color) => FaIcon(
            FontAwesomeIcons.tiktok,
            color: color,
            size: 22,
          ),
          onTap: () => _launchSocialUrl(
            'https://www.tiktok.com/@cadcode.academy?_r=1&_t=ZS-99UuseG3TPh',
          ),
          customColor: const Color(0xFF000000),
        ),
        SettingsListTile(
          title: 'LinkedIn',
          iconBuilder: (color) => FaIcon(
            FontAwesomeIcons.linkedinIn,
            color: color,
            size: 22,
          ),
          onTap: () => _launchSocialUrl(
            'https://www.linkedin.com/company/codenova-academy/',
          ),
          customColor: const Color(0xFF0A66C2),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          const BrandHeader(title: 'Settings')
              .animate()
              .fade(duration: 400.ms)
              .slideY(begin: -0.2, curve: Curves.easeOutQuad),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 24.0,
                bottom: 120.0,
              ),
              child: ResponsiveConstraint(
                tabletMaxWidth: showTwoColumns ? 1000 : 600,
                child: showTwoColumns
                    ? IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: accountCard
                                  .animate()
                                  .fade(duration: 400.ms, delay: 100.ms)
                                  .slideY(begin: 0.1, curve: Curves.easeOutQuad),
                            ),
                            const SizedBox(width: 28),
                            Expanded(
                              child: socialCard
                                  .animate()
                                  .fade(duration: 400.ms, delay: 200.ms)
                                  .slideY(begin: 0.1, curve: Curves.easeOutQuad),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          accountCard
                              .animate()
                              .fade(duration: 400.ms, delay: 100.ms)
                              .slideY(begin: 0.1, curve: Curves.easeOutQuad),
                          const SizedBox(height: 24),
                          socialCard
                              .animate()
                              .fade(duration: 400.ms, delay: 200.ms)
                              .slideY(begin: 0.1, curve: Curves.easeOutQuad),
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
