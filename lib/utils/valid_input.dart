// check valid email string
bool validEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

// check valid password string
// condition:
// longer than 6 characters,
// contain at least 1 uppercase
bool validPassword(String password) {
  return password.length >= 6;
  // && RegExp(r"^(?=.*?[A-Z])").hasMatch(password);
}

// check valid phone string
bool validPhone(String phone) {
  return RegExp(r"^[0-9]{10}$").hasMatch(phone);
}
