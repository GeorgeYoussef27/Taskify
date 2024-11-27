import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskify/firestore/model/User.dart' as myUser;
import 'package:taskify/FirebaseAuthCodes.dart';
import 'package:taskify/firestore/FirestoreHandler.dart';
import 'package:taskify/style/constants.dart';
import 'package:taskify/style/reusable_components/CustomAlertDialog.dart';
import 'package:taskify/style/reusable_components/CustomButton.dart';
import 'package:taskify/style/reusable_components/CustomFormField.dart';
import 'package:taskify/style/reusable_components/CustomLoadingDialog.dart';
import 'package:taskify/ui/home/home_screen.dart';
import 'package:taskify/ui/register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text("Login"),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key:formKey ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomFormField(
                    controller: emailController,
                    label: "Email Address",
                    keyboard: TextInputType.emailAddress,
                    validate: (value){
                      if(value==null || value.isEmpty){
                        return "Please Enter Your Email Address";
                      }
                      if(!isValidEmail(value)){
                        return "Enter Valid Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 0.01 * height),
                  CustomFormField(
                    controller: passwordController,
                    label: "Password",
                    isPassword: true,
                    validate: (value){
                      if(value==null || value.isEmpty){
                        return "Please Enter Your Password";
                      }
                      if(value.length<8){
                        return "Password Should Be At Least 8";
                      }
                      return null;
                    },
                    keyboard: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 0.01 * height),
                  SizedBox(height: 0.05 * height),
                  CustomButton(
                    label: "Login",
                    onClick: (){
                      Login();
                    },
                  ),
                  SizedBox(height: 0.05 * height),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text("Or Create New Account",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Login()async{
    if(formKey.currentState?.validate()==true){
     try{
       showDialog(context: context, builder: (context) => CustomLoadingDialog());
       UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: emailController.text.trim(),
           password: passwordController.text);
       myUser.User? user = await FirestoreHandler.ReadUser(
         credential.user!.uid
       );
       Navigator.pop(context);
       Navigator.pushReplacementNamed(context,HomeScreen.routeName);

     } on FirebaseAuthException catch (e) {
       Navigator.pop(context);
       if (e.code == FirebaseAuthCodes.userNotFound) {
         showDialog(context: context, builder: (context) => CustomAlertDialog(
           positiveBtnPress: (){
             Navigator.pop(context);
           },
           dialogColor: Color(0xfffe0000),
             dialogLabel: "No user found for that email"),);
       } else if (e.code == FirebaseAuthCodes.wrongPassword ) {
         showDialog(context: context, builder: (context) => CustomAlertDialog(
           positiveBtnPress: (){
             Navigator.pop(context);
           },
           dialogColor: Color(0xfffe0000),
             dialogLabel: "Wrong password"),);
       }
    }
  }
}
}
