import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance_app/screens/homescreen/home_screen.dart';
import 'package:freelance_app/screens/user/signup_screen.dart';
import 'package:freelance_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart' hide badge;

import 'package:freelance_app/config/firebase_auth_service.dart';
import 'package:freelance_app/widgets/custom_button.dart';
import 'package:freelance_app/screens/user/forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.deepPurple,
          ),
          automaticallyImplyLeading: true,

          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Image(
              height: 50,
              width: 150,
              image: AssetImage("assets/images/logo.png"),),
          ),
        ),

        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Container(
                //     height: 50,
                //     width: 50,
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Colors.black, width: 1),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: IconButton(
                //         icon: const Icon(Icons.arrow_back_ios_sharp),
                //         onPressed: () {
                //           Navigator.pop(context);
                //         }),
                //   ),
                // ),
                SizedBox(
                  height: 80,
                ),
                 Padding(
                  padding: EdgeInsets.all(10.0),

                  child: Center(
                    child: Text("Welcome Back! \nGlad to see you again",


                        style: TextStyle(

                          color: Colors.black54,
                          fontSize: 30,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                SizedBox(height:30),
                CustomTextfield(
                  myController: _emailController,
                  hintText: "Enter your Email",
                  isPassword: false,
                ),
                CustomTextfield(
                  myController: _passwordController,
                  hintText: "Enter your Password",
                  isPassword: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                            color: Color(0xff6A707C),
                            fontSize: 15,
                          )),
                    ),
                  ),
                ),
                CustomButton(
                  buttonText: "Login",
                  buttonColor: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      await FirebaseAuthService().login(
                          _emailController.text.trim(),
                          _passwordController.text.trim());

                      if (FirebaseAuth.instance.currentUser != null) {
                        setState(() {
                          _isLoading = true;
                        });
                        if (!mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homescreen()));
                      }
                    } on FirebaseException catch (e) {
                      debugPrint("error is ${e.message}");
                      setState(
                        () {
                          _isLoading = false;
                        },
                      );

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0))),

                                  title: Text(
                                      "Invalid Username or password. Please register again or make sure that username and password is correct",
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 15,
                                  ),),
                              actions: [
                                    ElevatedButton(
                                      child: const Text("Register Now"),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpScreen()));
                                      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          )
                                  ]));
                    }

                    // Navigator.push(context,
                    //    MaterialPageRoute(builder: (_) => const LoginScreen()));

                    setState(
                      () {
                        _isLoading = false;
                      },
                    );
                  },
                ),
                /*
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.15,
                        color: Colors.grey,
                      ),
                      const Text("               "),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.height * 0.18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          )),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            // color: Colors.blue,
                          ),
                          onPressed: () async {
                            await FirebaseAuthService().logininwithgoogle();

                            if (FirebaseAuth.instance.currentUser != null) {
                              if (!mounted) return;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Homescreen()));
                            } else {
                              throw Exception("Error");
                            }
                          },
                        ),
                      ),
                      Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.apple,
                              // color: Colors.blue,
                            ),
                            onPressed: () {},
                          ))
                    ],
                  ),
                ),
                */
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 8, 8, 8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(
                            color: Color(0xff1E232C),
                            fontSize: 15,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: const Text("  Register Now",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 15,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _progressIndicator() {
    return const Center(
      child: SizedBox(
        height: 70,
        width: 70,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
