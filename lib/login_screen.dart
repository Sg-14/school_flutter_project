import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase integration

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Email Input
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email id");
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email id");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next, // To show next button in keyboard
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          hintText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15)),
    );

    // Password Input
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      // keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regx = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Enter your password");
        }
        if (!regx.hasMatch(value)) {
          return ("Password should have atleast 6 characters");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done, // To show next button in keyboard
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.key),
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15)),
      obscureText: true,
    );

    // Login Button

    final loginButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      color: const Color(0xff4D7482),
      child: MaterialButton(
        onPressed: () {
          siginIn(emailController.text, passwordController.text);
        },
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: const Text(
          'Login',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset('images/logo2.png'),
                  ),
                  emailField,
                  const SizedBox(
                    height: 30,
                  ),
                  passwordField,
                  const SizedBox(
                    height: 30,
                  ),
                  loginButton
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Login function

  void siginIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login successful"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
