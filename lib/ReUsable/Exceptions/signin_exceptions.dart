class SignUpWithEmailAndPasswordFailure {
  final String msg;

  SignUpWithEmailAndPasswordFailure({this.msg = 'An unknown error occurred.'});

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
            msg: 'Please enter strong password');
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure(
            msg: 'Email is not valid or badly formatted.');
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
            msg: 'An account already exist for that account.');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
            msg: 'Operation is not allowed.Please contact the support.');
      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailure(
            msg:
                'The user is currently disabled.Please contact support for help.');
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
            msg: 'Please enter strong password');
      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }
}
