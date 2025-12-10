// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'DMT Movie';

  @override
  String get homeTitle => 'Phim';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get searchTitle => 'Tìm kiếm';

  @override
  String get openSettings => 'Mở cài đặt';

  @override
  String get seeDetails => 'Xem chi tiết';

  @override
  String get noMovies => 'Không có phim';

  @override
  String get tabHome => 'Trang chủ';

  @override
  String get tabSearch => 'Tìm kiếm';

  @override
  String get tabSettings => 'Cài đặt';

  @override
  String get loginTitle => 'Đăng nhập / Đăng ký';

  @override
  String get loginSubtitle => 'Nhập email để tiếp tục';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'example@email.com';

  @override
  String get emailRequired => 'Email không được để trống';

  @override
  String get emailInvalid => 'Email không hợp lệ';

  @override
  String get password => 'Mật khẩu';

  @override
  String get passwordHint => 'Nhập mật khẩu';

  @override
  String get passwordRequired => 'Mật khẩu không được để trống';

  @override
  String passwordMinLength(int length) {
    return 'Mật khẩu phải có ít nhất $length ký tự';
  }

  @override
  String get continue => 'Tiếp tục';

  @override
  String get cancel => 'Huỷ';

  @override
  String get save => 'Lưu';

  @override
  String get delete => 'Xoá';

  @override
  String get edit => 'Sửa';

  @override
  String get add => 'Thêm';

  @override
  String get back => 'Quay lại';

  @override
  String get retry => 'Thử lại';

  @override
  String get ok => 'Đồng ý';

  @override
  String get otpTitle => 'Nhập mã OTP';

  @override
  String otpSubtitle(String email) {
    return 'Nhập mã OTP đã được gửi đến $email';
  }

  @override
  String get otpCode => 'Mã OTP';

  @override
  String get otpHint => 'Nhập mã OTP';

  @override
  String get otpRequired => 'Mã OTP không được để trống';

  @override
  String otpInvalid(int length) {
    return 'Mã OTP phải có $length chữ số';
  }

  @override
  String get resendOtp => 'Gửi lại mã OTP';

  @override
  String get backToLogin => 'Quay lại màn hình đăng nhập';

  @override
  String get otpVerified => 'Xác thực thành công';

  @override
  String get otpResent => 'Mã OTP đã được gửi lại';

  @override
  String get selectProfile => 'Ai đang xem?';

  @override
  String get manageProfiles => 'Quản lý hồ sơ';

  @override
  String get addProfile => 'Thêm';

  @override
  String get addNewProfile => 'Thêm hồ sơ mới';

  @override
  String get editProfile => 'Sửa hồ sơ';

  @override
  String maxProfilesReached(int max) {
    return 'Đã đạt giới hạn $max hồ sơ';
  }

  @override
  String profileSelected(String name) {
    return 'Đã chọn $name';
  }

  @override
  String get user => 'Người dùng';

  @override
  String get kids => 'Trẻ em';

  @override
  String get name => 'Tên';

  @override
  String get nameHint => 'Nhập tên';

  @override
  String get nameRequired => 'Tên không được để trống';

  @override
  String nameMinLength(int length) {
    return 'Tên phải có ít nhất $length ký tự';
  }

  @override
  String nameMaxLength(int length) {
    return 'Tên không được vượt quá $length ký tự';
  }

  @override
  String get phone => 'Số điện thoại';

  @override
  String get phoneHint => 'Nhập số điện thoại';

  @override
  String get phoneRequired => 'Số điện thoại không được để trống';

  @override
  String get phoneInvalid => 'Số điện thoại không hợp lệ';

  @override
  String get theme => 'Giao diện';

  @override
  String get themeSystem => 'Hệ thống';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get languageSystem => 'Hệ thống';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageVietnamese => 'Tiếng Việt';

  @override
  String get error => 'Lỗi';

  @override
  String get success => 'Thành công';

  @override
  String get warning => 'Cảnh báo';

  @override
  String get info => 'Thông tin';

  @override
  String get loadingMovies => 'Đang tải phim...';

  @override
  String errorLoadingMovies(String error) {
    return 'Không thể tải danh sách phim: $error';
  }

  @override
  String get termsAccept => 'Tôi đã đọc dòng ';

  @override
  String get termsText => 'Không thêm cũng được, nhưng thêm vô nhìn cho sang chảnh hơn, hiểu hông mấy má 😏';

  @override
  String get registerSuccess => 'Đăng ký thành công';

  @override
  String get loginSuccess => 'Đăng nhập thành công';

  @override
  String get movieDetails => 'Chi tiết phim';

  @override
  String movieId(String id) {
    return 'ID Phim: $id';
  }
}
