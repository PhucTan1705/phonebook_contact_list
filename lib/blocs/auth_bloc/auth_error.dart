import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/foundation.dart' show immutable;

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),

};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;

  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
      const AuthErrorUnknown();
}

@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(
          dialogTitle: 'Lỗi xác thực',
          dialogText: 'Lỗi xác thực không xác định',
        );
}

//auth/no-current-user

@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          dialogTitle: 'Người dùng không tồn tại',
          dialogText: 'Không tồn tại người với thông tin được cung cấp!',
        );
}

//auth/requires-recent-login

@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          dialogTitle: 'Cần đăng nhập lại',
          dialogText: 'Bạn cần đăng nhập lại để có thể tiếp tục thực hiện thao tác',
        );
}

@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed ()
      : super(
          dialogTitle: 'Thao tác không hợp lệ',
          dialogText: 'Không thể thực hiện thao tác!',
        );
}

@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound ()
      : super(
          dialogTitle: 'Không tìm thấy người dùng',
          dialogText: 'Không tồn tại người với thông tin được cung cấp!',
        );
}

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword ()
      : super(
          dialogTitle: 'Mật khẩu yếu',
          dialogText: 'Xin vui lòng tạo mật khẩu khác!',
        );
}

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail ()
      : super(
          dialogTitle: 'Email không hợp lệ',
          dialogText: 'Xin vui kiểm tra lại email của bạn!',
        );
}

@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse ()
      : super(
          dialogTitle: 'Email đã được sử dụng',
          dialogText: 'Xin vui sử dụng một email khác!',
        );
}




