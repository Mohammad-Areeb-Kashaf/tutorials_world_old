String checkLoginAuthError(
    {required e,
    required bool isEmail,
    required bool isUser,
    required bool isPassword}) {
  String error = e.toString();
  if (isEmail) {
    if (error ==
        '[firebase_auth/invalid-email] The email address is badly formatted.') {
      return 'Looks like your email is invalid.';
    }
  } else if (isPassword) {
    if (error ==
        '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
      return 'Password is incorrect';
    }
  } else if (isUser) {
    if (error ==
        '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
      return 'User is not found';
    } else if (error ==
        '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.') {
      return 'Too many request from this device. Please try again later';
    }
  }
  return error;
}

String checkRegisterAuthError({required e, required isEmail, required isUser}) {
  String error = e.toString();
  if (isEmail) {
    if (error ==
        '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
      return 'Email already in use, Login instead?';
    } else if (error ==
        '[firebase_auth/invalid-email] The email address is badly formatted.') {
      return 'This email address is not correctly formatted';
    } else {
      return error;
    }
  } else if (isUser) {
    if (error ==
        '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
      return 'Internet unavailable. Please connect your mobile to a internet connection';
    } else {
      return error;
    }
  } else {
    return error;
  }
}
