import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AuthState.dart';

class AuthCubit extends Cubit<AuthState>{
  final _auth=FirebaseAuth.instance;
  String ?_verificationId;
  AuthCubit():super(AuthIntState()){
    User ? currenUser=_auth.currentUser;
    if(currenUser!=null){
      emit(LoggedIntState(currenUser));

    }else{
      print("loged out state is emitted");
      emit(LogedOutState());
    }

  }
   void sendOtp(String number){
     emit(LoadingState());
     _auth.verifyPhoneNumber(
      phoneNumber: number,
        codeSent: (verificationId,forseResndinToken){
          _verificationId=verificationId;
          emit(CodeSentSate());

        },
       verificationCompleted: (PhoneAuthCredential credential){
         signInWithphone(credential);

       },
       verificationFailed: (error){
        emit(ErrorState(error.message));

     },
       codeAutoRetrievalTimeout: (verificationId){
        _verificationId=verificationId;

       }

         );

   }
   void backtoCodesent(){
     emit(AuthIntState());
   }
   void verifOtp(String otp)async{
     emit(LoadingState());
     PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
     signInWithphone(credential);

   }
   void signInWithphone(PhoneAuthCredential credential)async{
     try{
        UserCredential userCredential= await _auth.signInWithCredential(credential);
        if(userCredential.user!=null){
          emit(LoggedIntState(userCredential.user));
        }

     } on FirebaseAuthException catch (ex){
       emit(ErrorState(ex.message.toString()));

     }

   }
  logOut()async{
    await _auth.signOut();
    emit(LogedOutState());
  }
  // logInValidator(str){
  //   if(str.toString().length>10){
  //     emit(ValidState());
  //   }
  //   else if(str.toString().isEmpty){
  //     emit(ValidState());
  //   }
  // }

}
