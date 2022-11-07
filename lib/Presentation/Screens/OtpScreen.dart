import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_phone/BLogic/AuthCubit.dart';
import 'package:login_with_phone/BLogic/AuthState.dart';
import 'package:login_with_phone/main.dart';
class OtpScreen extends StatelessWidget {
   OtpScreen({Key? key}) : super(key: key);
  final codeController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Otpo"),
      ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(

            children: [
              TextFormField(
                controller: codeController,
              ),
              BlocConsumer<AuthCubit,AuthState>(
                listener: (context,state){
                  if(state is LoggedIntState){
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                  }
                  else if(state is ErrorState){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 6),
                        backgroundColor: Colors.red,

                        content: Text(state.message.toString()
                    )
                    ));
                  }

                },
                builder: (context, state) {
                  if(state is LoadingState){
                    return Center(
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator()),
                    );
                  }
                  return ElevatedButton(onPressed: (){
                    BlocProvider.of<AuthCubit>(context).verifOtp(codeController.text);

                  }, child: Text(
                    "Verify"
                  ));
                }
              )
            ],
          ),
        )
    );
  }
}
