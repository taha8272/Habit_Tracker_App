import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:glass/glass.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

final firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  var _selectedEmail;
  var _selectedPassword;
  bool isLogin = true;
  void changeLoginState() {
    if (isLogin == true) {
      setState(() {
        isLogin = false;
      });
    } else {
      setState(() {
        isLogin = true;
      });
    }
  }

  void SignUserIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    try {
      if (isLogin) {
        final userCredentials = await firebase.signInWithEmailAndPassword(
          email: _selectedEmail,
          password: _selectedPassword,
        );
      } else {
        final userCredentials = await firebase.createUserWithEmailAndPassword(
          email: _selectedEmail,
          password: _selectedPassword,
        );
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Authentication Error')),
      );
    }
  }

  void signInWithGoogle(BuildContext context) async {
    try {
      // Initialize with web client ID
      await GoogleSignIn.instance.initialize(
        serverClientId:
            "dummy",
      );

      // Trigger the Google Sign-In flow
      final googleUser = await GoogleSignIn.instance.authenticate();
      if (googleUser == null) return;

      // Get authentication details
      final googleAuth = await googleUser.authentication;

      // Build Firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Google sign-in failed")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A344D), Color(0xFF1D6C8B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child:
              Container(
                height: 500,
                width: 330,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Welcome Back', style: h1),
                        const SizedBox(height: 10),
                        Text('Login to your account', style: text),
                        const SizedBox(height: 20),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 16,
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Email',
                                      style: TextStyle(color: Colors.white54),
                                    ),

                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.white70,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  style: TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !value.contains('@gmail.com')) {
                                      return 'Invalid Email Address';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    _selectedEmail = newValue;
                                  },
                                ),

                                const SizedBox(height: 20),

                                TextFormField(
                                  obscureText: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Password',
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.white70,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length < 6) {
                                      return 'Password must be atleast 6 characters long';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    _selectedPassword = newValue;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: SignUserIn,
                            style: ElevatedButton.styleFrom(),
                            child: Text(
                              isLogin ? 'Login' : 'Sign up',
                              style: text.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLogin
                                  ? 'Dont have an account?'
                                  : 'Already have an account?',
                              style: text,
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: changeLoginState,
                              child: Text(
                                isLogin ? 'Sign up' : 'Sign in',
                                style: text.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            signInWithGoogle(context);
                          },
                          child: Text('Sign in with google'),
                        ),
                      ],
                    ),
                  ),
                ),
              ).asGlass(
                frosted: false,
                blurX: 30,
                blurY: 30,
                tintColor: Colors.white.withValues(alpha: 0.1),
                clipBorderRadius: BorderRadius.circular(17),
              ),
        ),
      ),
    );
  }
}
