abstract class Validations{
  static bool validateEmail(String email){
    final RegExp emailRegExp =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }
  static String? validatePassword(String password){
    final RegExp passwordRegExp =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (password.isEmpty) {
      return "Password is required";
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters or digit';
    }
    if (!passwordRegExp.hasMatch(password)) {
      return 'Include at least one uppercase letter';
    }
    if (!passwordRegExp.hasMatch(password)) {
      return 'Include at least one number';
    }

    return null;
  }
}