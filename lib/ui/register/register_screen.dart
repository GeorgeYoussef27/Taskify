import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskify/firestore/model/User.dart' as myUser;
import 'package:flutter/material.dart';
import 'package:taskify/FirebaseAuthCodes.dart';
import 'package:taskify/firestore/FirestoreHandler.dart';
import 'package:taskify/style/constants.dart';
import 'package:taskify/style/reusable_components/CustomAlertDialog.dart';
import 'package:taskify/style/reusable_components/CustomButton.dart';
import 'package:taskify/style/reusable_components/CustomFormField.dart';
import 'package:taskify/style/reusable_components/CustomLoadingDialog.dart';
import 'package:taskify/ui/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          title: Text("Create Account"),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFormField(
                      controller: fullNameController,
                      label: "Full Name",
                      keyboard: TextInputType.name,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 0.01 * height,
                    ),
                    CustomFormField(
                      controller: emailController,
                      label: "Email Address",
                      keyboard: TextInputType.emailAddress,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Email Address";
                        }
                        if (!isValidEmail(value)) {
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 0.01 * height),
                    CustomFormField(
                      controller: ageController,
                      label: "Age",
                      maxLength: 2,
                      keyboard: TextInputType.number,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Age";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 0.01 * height),
                    CustomFormField(
                      maxLength: 11,
                      controller: phoneNumberController,
                      label: "Phone Number",
                      keyboard: TextInputType.phone,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Phone Number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 0.01 * height),
                    CustomFormField(
                      controller: passwordController,
                      label: "Password",
                      isPassword: true,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Password";
                        }
                        if (value.length < 8) {
                          return "Password Should Be At Least 8";
                        }
                        return null;
                      },
                      keyboard: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 0.01 * height),
                    CustomFormField(
                      controller: confirmPasswordController,
                      label: "Confirm Password",
                      isPassword: true,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Confirm Your Password";
                        }
                        if (value != passwordController.text) {
                          return "Password Not Match";
                        }
                        return null;
                      },
                      keyboard: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 0.05 * height),
                    CustomButton(
                      label: "Create Account",
                      onClick: () {
                        createAccount();

                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  createAccount() async {
    if (formKey.currentState?.validate() == true) {
      try {
        showDialog(
          context: context,
          builder: (context) => CustomLoadingDialog(),
        );
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text,
            password: passwordController.text,
        );
        showDialog(context: context,
            builder: (context) =>CustomAlertDialog(
              positiveBtnPress: (){
                Navigator.pop(context);
              },
                dialogLabel: "Your account has been created successfully."));
        await FirestoreHandler.createUser(myUser.User(
          id: userCredential.user!.uid,
          fullName: fullNameController.text,
          emailAddress: emailController.text,
          phoneNumber: phoneNumberController.text,
          age: int.parse(ageController.text),
        ));
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == FirebaseAuthCodes.weakPassword) {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              positiveBtnPress: (){
                Navigator.pop(context);
              },
              dialogColor: Color(0xfffe0000),
                dialogLabel: "The password provided is too weak.",
            ),
          );
        } else if (e.code == FirebaseAuthCodes.emailAlreadyInUse) {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              positiveBtnPress: (){
                Navigator.pop(context);
              },
                dialogColor: Color(0xfffe0000),
                dialogLabel: "The account already exists for that email"),
          );
        }
      } catch (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) =>
              CustomAlertDialog(
                positiveBtnPress: (){
                  Navigator.pop(context);
                },
                dialogColor: Color(0xfffe0000),
                  dialogLabel: error.toString()),
        );
      }
    }
  }
}
