import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_with_phone/BLogic/AuthCubit.dart';
import 'package:login_with_phone/BLogic/AuthState.dart';

import 'Presentation/Screens/LoginInScreen.dart';

void main()async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
init()async{
 await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>AuthCubit(),

        child :MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder<AuthCubit,AuthState>(
            // buildWhen: (oldstate,newState){
            //   return oldstate is AuthIntState;
            //
            // },
            builder: (context,state) {

              if(state is AuthIntState ){
                return PhoneLoginSreen();
              }
              else if(state is LoggedIntState){
                  return MyHomePage();
                }

              return splasScreen();
            }
          )

        )
    );
  }
}
class splasScreen extends StatefulWidget {
  int a=0 ,b=0,c=0;
   splasScreen({Key? key}) : super(key: key);

  @override
  _splasScreenState createState() => _splasScreenState();
}

class _splasScreenState extends State<splasScreen> {
 //  @override
 //  void initState() {
 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PhoneLoginSreen()));
 //    super.initState();
 //  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}


class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Home page"),
      ),
          body: Column(
            children: [
              Spacer(flex: 4),
              Container(
                child: const Center(
                  child: Text("Home page"),

                ),
              ),
              Spacer(flex: 4),
              BlocConsumer<AuthCubit,AuthState>(
                listener: (context,state){
                  if(state is LogedOutState){
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PhoneLoginSreen()));
                  }

                },
                builder: (context,state) {
                  return ElevatedButton(onPressed: (){
                    BlocProvider.of<AuthCubit>(context).logOut();

                  }, child: Text("LogOut"));
                }
              ),
            ],
          ),
    );

  }
}
