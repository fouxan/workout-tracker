///login exceptions
class UserNotFoundException implements Exception {}

class WrongPasswordException implements Exception {}

///register exceptions
class EmailInUseException implements Exception {}

class WeakPasswordException implements Exception {}

///generic exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInException implements Exception {}
