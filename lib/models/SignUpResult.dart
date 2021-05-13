// represents the values of a sign up result
enum SignUpResult {
  SUCCESS,
  WEAK_PASSWORD,
  EMAIL_IN_USE,
  FAIL // general fail for cases that are not weak password or email in use
}