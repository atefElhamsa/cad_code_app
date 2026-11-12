import 'package:flutter/material.dart';

import '../core/responsive/responsive.dart';
import '../core/theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onFieldSubmitted;
  final double? fieldHeight;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.textInputAction,
    this.autofillHints,
    this.onFieldSubmitted,
    this.fieldHeight,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = widget.fieldHeight ?? (context.isTablet ? 56.0 : 52.0);
    final fontSize = ResponsiveUtils.fontSize(
      context,
      16,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return SizedBox(
      height: effectiveHeight,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        autofillHints: widget.autofillHints,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: _obscureText,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontFamily: 'Inter',
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: fontSize,
            fontFamily: 'Inter',
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: AppTheme.primaryGoldLight,
            size: context.isTablet ? 22 : 20,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.primaryGoldLight.withValues(alpha: 0.5),
                    size: context.isTablet ? 22 : 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : widget.suffixIcon,
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppTheme.primaryGoldLight.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppTheme.primaryGoldLight,
              width: 1.8,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
