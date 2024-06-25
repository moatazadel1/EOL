class Validators {
  static String? displayNamevalidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Display name cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'Display name must be between 3 and 20 characters';
    }

    return null; // Return null if display name is valid
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return "Passwords don't match";
    }
    return null;
  }

  static String? titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title cannot be empty';
    }
    if (value.length < 3 || value.length > 50) {
      return 'Title must be between 3 and 50 characters';
    }
    return null; // Return null if title is valid
  }

  static String? messageValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Message cannot be empty';
    }
    if (value.length < 10 || value.length > 200) {
      return 'Message must be between 10 and 200 characters';
    }
    return null; // Return null if description is valid
  }
}
