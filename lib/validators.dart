String emailValidator(String value) {

  value = value.trim();

  if (value.endsWith('@gmail.com'))
    return (null);
  else if (value.endsWith('@iul.ac.in'))
    return (null);
  else
    return ('Email not supported');

}

String pwdValidator(String value) {
  if (value.length < 6) {
    return 'Password must be longer than 6 characters';
  } else {
    return null;
  }
}