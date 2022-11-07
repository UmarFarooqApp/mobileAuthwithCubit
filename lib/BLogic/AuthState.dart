import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{

}

class AuthIntState extends AuthState{

}
class CodeSentSate extends AuthState{

}
class CodeVerifiedState extends AuthState{

}

class LoadingState extends AuthState{


}
class LogedOutState extends AuthState{


}

class LoggedIntState extends AuthState{
  User ?fireBaseUser;
  LoggedIntState(this.fireBaseUser);

}

class ValidState extends AuthState{

}

 class ErrorState extends AuthState{
  String? message;
  ErrorState(this.message);

}



