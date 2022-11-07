import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_phone/BLogic/AuthCubit.dart';
import 'package:login_with_phone/BLogic/AuthState.dart';
import 'package:login_with_phone/Presentation/Screens/OtpScreen.dart';
class PhoneLoginSreen extends StatelessWidget {
   PhoneLoginSreen({Key? key}) : super(key: key);
  final phoneController=TextEditingController();
  final _key=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LogIn"),
        ),
        body: BlocConsumer<AuthCubit,AuthState>(
          listener: (context, state) {
            if(state is CodeSentSate){
              Navigator.push(context, CupertinoPageRoute(builder: (context)=>OtpScreen()));
             // BlocProvider.of<AuthCubit>(context).backtoCodesent();
            }

          },
          builder: (context,state) {
            if(state is LoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(

                children: [
                  Form(
                    key: _key,
                    child: TextFormField(
                      validator: (val){
                        if(val.toString().isEmpty){
                          return "Please Enter a PhoneNumber";
                        }
                        if(val.toString().length>10 && val.toString().length<10){
                          return"Number is  not valid";
                        }
                      },
                      controller: phoneController,
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                   // if(_key.currentState.)

                    String number="+92${phoneController.text}";
                   BlocProvider.of<AuthCubit>(context).sendOtp(number);
                  },

                   child: Text(
                      "LogIn"
                  ))
                ],
              ),
            );
          }
        )
    );
  }
}

