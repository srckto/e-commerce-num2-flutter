String _emptyString = "    "; // Don't change this line

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return _emptyString + "Please enter your email";
  if (value.length < 6) return _emptyString + "Email is too short!";
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return _emptyString + "Password must not be empty";
  if (value.length < 6) return _emptyString + "Password is too short!";
  return null;
}

String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) return _emptyString + "Please enter your username";
  if (value.trim().isEmpty) return _emptyString + "Please enter your username";
  if (value.length < 5) return _emptyString + "username is too short!";
  // for (var i = 0; i < value.length; i++) {
  //   bool found = value[i].contains(new RegExp(r'[0-9]'));
  //   if (found) return _emptyString + "Please enter your name with out any number";
  // }
  return null;
}

String? searchValidator(String? value) {
  if (value == null || value.isEmpty) return _emptyString + "The field mustn't be empty";
  if (value.trim().isEmpty) return _emptyString + "The field mustn't be empty";
  return null;
}

String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) return _emptyString + "The field mustn't be empty";
  if (value.trim().isEmpty) return _emptyString + "The field mustn't be empty";
  int? parseNumber = int.tryParse(value);
  if (parseNumber == null) return _emptyString + "Please enter valid number";
  if (value.trim().length < 6) return _emptyString + "Please enter valid number";
  return null;
}
