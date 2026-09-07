import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/brand_header.dart';
import '../../../core/theme/app_theme.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Unified off-white background
      body: Column(
        children: [
          const BrandHeader(title: 'Settings')
              .animate()
              .fade(duration: 400.ms)
              .slideY(begin: -0.2, curve: Curves.easeOutQuad),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                _buildCard([
                      _buildListTile(
                        context,
                        'Profile',
                        (color) =>
                            Icon(Icons.person_rounded, color: color, size: 22),
                        () => context.push('/profile'),
                      ),
                      _buildListTile(
                        context,
                        'Downloads',
                        (color) => Icon(
                          Icons.cloud_download_rounded,
                          color: color,
                          size: 22,
                        ),
                        () => context.push('/downloads'),
                      ),
                      _buildListTile(
                        context,
                        'Payment',
                        (color) =>
                            Icon(Icons.payment_rounded, color: color, size: 22),
                        () => context.push('/payment'),
                      ),
                    ])
                    .animate()
                    .fade(duration: 400.ms, delay: 100.ms)
                    .slideY(begin: 0.1, curve: Curves.easeOutQuad),

                const SizedBox(height: 24),

                // Social Media Group
                _buildCard([
                      _buildListTile(
                        context,
                        'Facebook',
                        (color) => FaIcon(
                          FontAwesomeIcons.facebook,
                          color: color,
                          size: 22,
                        ),
                        () => _launchSocialUrl(
                          'https://www.facebook.com/share/1FEBzBSYa4/',
                        ),
                        customColor: const Color(0xFF1877F2),
                      ),
                      _buildListTile(
                        context,
                        'WhatsApp',
                        (color) => FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: color,
                          size: 22,
                        ),
                        () => _launchSocialUrl('https://wa.me/201272442829'),
                        customColor: const Color(0xFF25D366),
                      ),
                      _buildListTile(
                        context,
                        'Instagram',
                        (color) => FaIcon(
                          FontAwesomeIcons.instagram,
                          color: color,
                          size: 22,
                        ),
                        () => _launchSocialUrl(
                          'https://www.instagram.com/cadcode.academy?utm_source=qr&stkn=NDMybmFqeXZhbDlk',
                        ),
                        customColor: const Color(0xFFE1306C),
                      ),
                      _buildListTile(
                        context,
                        'TikTok',
                        (color) => FaIcon(
                          FontAwesomeIcons.tiktok,
                          color: color,
                          size: 22,
                        ),
                        () => _launchSocialUrl(
                          'https://www.tiktok.com/@cadcode.academy?_r=1&_t=ZS-99UuseG3TPh',
                        ),
                        customColor: const Color(0xFF000000),
                      ),
                      _buildListTile(
                        context,
                        'LinkedIn',
                        (color) => FaIcon(
                          FontAwesomeIcons.linkedinIn,
                          color: color,
                          size: 22,
                        ),
                        () => _launchSocialUrl(
                          'https://www.linkedin.com/company/codenova-academy/',
                        ),
                        customColor: const Color(0xFF0A66C2),
                      ),
                    ])
                    .animate()
                    .fade(duration: 400.ms, delay: 200.ms)
                    .slideY(begin: 0.1, curve: Curves.easeOutQuad),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    List<Widget> separatedChildren = [];
    for (int i = 0; i < children.length; i++) {
      separatedChildren.add(children[i]);
      if (i < children.length - 1) {
        separatedChildren.add(
          Padding(
            padding: const EdgeInsets.only(left: 80.0, right: 20.0),
            child: Divider(height: 1, color: Colors.grey.shade100),
          ),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(children: separatedChildren),
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    String title,
    Widget Function(Color) iconBuilder,
    VoidCallback onTap, {
    bool isDestructive = false,
    Color? customColor,
  }) {
    final Color iconColor =
        customColor ??
        (isDestructive ? const Color(0xFFE53935) : AppTheme.primaryCyan);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: iconBuilder(iconColor).animate().scale(
            delay: 400.ms,
            duration: 400.ms,
            curve: Curves.easeOutBack,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? iconColor : AppTheme.textDarkNavy,
          fontWeight:
              FontWeight.w700, // Reduced from w900 for a more elegant look
          fontSize: 16,
          fontFamily: 'Inter',
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey.shade300,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
