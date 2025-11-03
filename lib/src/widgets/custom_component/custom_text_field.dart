import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.prefixIcon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.textError = '',
    this.labelText,
  });

  final TextEditingController controller;
  final Icon? prefixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String textError;
  final String? labelText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  bool _isFocused = false;

  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.textError.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label (nếu có)
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
        ],

        // TextField
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword && _isObscured,
            keyboardType: widget.keyboardType,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF1a1a1a),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: hasError
                  ? const Color(0xFFFFF5F5)
                  : _isFocused
                      ? const Color(0xFFF8F9FA)
                      : Colors.white,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF999999),
              ),
              
              // Prefix Icon - chỉ hiện khi có
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12),
                      child: widget.prefixIcon,
                    )
                  : null,
              prefixIconConstraints: widget.prefixIcon != null
                  ? const BoxConstraints(minWidth: 48, minHeight: 24)
                  : const BoxConstraints(minWidth: 16),
              
              // Suffix Icon cho password
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: _toggleObscure,
                      icon: Icon(
                        _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: const Color(0xFF666666),
                        size: 22,
                      ),
                    )
                  : null,
              
              // Content padding điều chỉnh theo có icon hay không
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.prefixIcon == null ? 16 : 0,
                vertical: 16,
              ),
              
              // Border states
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: hasError ? const Color(0xFFFF3B30) : const Color(0xFFE5E5E5),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: hasError ? const Color(0xFFFF3B30) : const Color(0xFF007AFF),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFFF3B30),
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFFF3B30),
                  width: 2,
                ),
              ),
            ),
          ),
        ),

        // Error message
        if (hasError) ...[
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error_outline,
                color: Color(0xFFFF3B30),
                size: 16,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.textError,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFF3B30),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}