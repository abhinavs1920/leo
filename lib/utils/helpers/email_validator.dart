String? validateEmail(value) {
  bool isEmailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value ?? '');
  if (!isEmailValid) {
    return 'Please enter a valid email';
  }
  return null;
}
