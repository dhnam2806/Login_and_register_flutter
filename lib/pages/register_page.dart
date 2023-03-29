import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorial/pages/home_page.dart';
import 'package:firebasetutorial/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  VoidCallback showLoginPage;
  RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future signUp() async {
    if (_confirmPasswordController.text.trim() ==
        _passwordController.text.trim()) {
      // authenticate user and check if password matches
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // add user to firestore
      await FirebaseFirestore.instance.collection('users').add({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'age': int.parse(_ageController.text.trim()),
        'email': _emailController.text.trim(),
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password does not match'),
        ),
      );
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.android,
                    size: 100,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16.0),
                  // Hello
                  Text(
                    'Hello!',
                    style: GoogleFonts.bebasNeue(
                        textStyle: const TextStyle(
                      fontSize: 52,
                    )),
                  ),

                  const SizedBox(height: 8.0),

                  const Text('Register below to continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      )),

                  const SizedBox(height: 32.0),

                  // first name textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'First Name',
                          ),
                        ),
                      ),
                    ),
                  ),

                  // last name textfield
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Last Name',
                          ),
                        ),
                      ),
                    ),
                  ),

                  // age textfield
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Age',
                          ),
                        ),
                      ),
                    ),
                  ),

                  // email textfield
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),

                  // password textfield
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ),
                  ),

                  // confirm password textfield
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                          ),
                        ),
                      ),
                    ),
                  ),

                  // button login
                  const SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // no account? sign up
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.showLoginPage();
                        },
                        child: const Text(" Login",
                            style: TextStyle(
                              color: Colors.blue,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
