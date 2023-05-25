String? validatePassword(value) {
  if ((value?.length ?? 8) < 7) {
    return 'Password must be 7 characters long';
  }
  return null;
}
