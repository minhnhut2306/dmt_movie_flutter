import '../constants/app_constants.dart';

class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }
    if (!RegExp(AppConstants.emailRegex).hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    if (value.length < AppConstants.passwordMinLength) {
      return 'Mật khẩu phải có ít nhất ${AppConstants.passwordMinLength} ký tự';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại không được để trống';
    }
    if (!RegExp(AppConstants.phoneRegex).hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tên không được để trống';
    }
    if (value.length < AppConstants.nameMinLength) {
      return 'Tên phải có ít nhất ${AppConstants.nameMinLength} ký tự';
    }
    if (value.length > AppConstants.nameMaxLength) {
      return 'Tên không được vượt quá ${AppConstants.nameMaxLength} ký tự';
    }
    return null;
  }

  static String? required(String? value, {String fieldName = 'Trường này'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName không được để trống';
    }
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mã OTP không được để trống';
    }
    if (value.length != AppConstants.otpLength) {
      return 'Mã OTP phải có ${AppConstants.otpLength} chữ số';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mã OTP chỉ được chứa số';
    }
    return null;
  }

  static String? minLength(String? value, int min, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? "Trường này"} không được để trống';
    }
    if (value.length < min) {
      return '${fieldName ?? "Trường này"} phải có ít nhất $min ký tự';
    }
    return null;
  }

  static String? maxLength(String? value, int max, {String? fieldName}) {
    if (value != null && value.length > max) {
      return '${fieldName ?? "Trường này"} không được vượt quá $max ký tự';
    }
    return null;
  }
}