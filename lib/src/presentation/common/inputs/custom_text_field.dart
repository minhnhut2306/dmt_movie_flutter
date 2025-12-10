import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.keyboardType,
    this.isPassword = false,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.enabled = true,
    this.onChanged,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    if (widget.isPassword) {
      _isObscured = true;
    }
  }

  void _toggleObscure() {
    setState(() => _isObscured = !_isObscured);
  }

  void _onFocusChange(bool hasFocus) {
    setState(() => _isFocused = hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final hasError = _errorText != null && _errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: const TextStyle(
              fontSize: AppTextStyles.fontSizeL,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: AppDimensions.spacingS),
        ],
        Focus(
          onFocusChange: _onFocusChange,
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword && _isObscured,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            style: const TextStyle(
              fontSize: AppTextStyles.fontSize2XL,
              fontWeight: FontWeight.w400,
              color: Color(0xFF1a1a1a),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  hasError
                      ? const Color(0xFFFFF5F5)
                      : _isFocused
                      ? const Color(0xFFF8F9FA)
                      : Colors.white,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontSize: AppTextStyles.fontSize2XL,
                fontWeight: FontWeight.w400,
                color: Color(0xFF999999),
              ),
              counterText: '',
              prefixIcon:
                  widget.prefixIcon != null
                      ? Padding(
                        padding: EdgeInsets.only(
                          left: AppDimensions.paddingM,
                          right: AppDimensions.paddingS,
                        ),
                        child: Icon(widget.prefixIcon),
                      )
                      : null,
              prefixIconConstraints:
                  widget.prefixIcon != null
                      ? const BoxConstraints(minWidth: 48, minHeight: 24)
                      : BoxConstraints(minWidth: AppDimensions.paddingM),
              suffixIcon:
                  widget.isPassword
                      ? IconButton(
                        onPressed: _toggleObscure,
                        icon: Icon(
                          _isObscured
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF666666),
                          size: 22,
                        ),
                      )
                      : null,
              contentPadding: EdgeInsets.symmetric(
                horizontal:
                    widget.prefixIcon == null ? AppDimensions.paddingM : 0,
                vertical: AppDimensions.paddingM,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: BorderSide(
                  color:
                      hasError
                          ? const Color(0xFFFF3B30)
                          : const Color(0xFFE5E5E5),
                  width: AppDimensions.inputBorderWidth,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: BorderSide(
                  color:
                      hasError
                          ? const Color(0xFFFF3B30)
                          : const Color(0xFF007AFF),
                  width: AppDimensions.inputBorderWidthFocused,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(
                  color: Color(0xFFFF3B30),
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(
                  color: Color(0xFFFF3B30),
                  width: 2,
                ),
              ),
              errorStyle: const TextStyle(height: 0),
            ),
            validator: (value) {
              final error = widget.validator?.call(value);
              setState(() => _errorText = error);
              return error;
            },
          ),
        ),
        if (hasError) ...[
          SizedBox(height: AppDimensions.spacingS),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error_outline,
                color: Color(0xFFFF3B30),
                size: 16,
              ),
              SizedBox(width: AppDimensions.spacingXS + 2),
              Expanded(
                child: Text(
                  _errorText!,
                  style: const TextStyle(
                    fontSize: AppTextStyles.fontSizeBase,
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
