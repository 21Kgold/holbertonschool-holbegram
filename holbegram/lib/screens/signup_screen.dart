// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/widgets/text_field.dart';

// Stateful widgets can change over time
class SignUp extends StatefulWidget {
  const SignUp({
    super.key
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  // ignore: prefer_final_fields
  bool _passwordVisible = true;
  
  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [

    // Logo
          SizedBox(
            height: 28.0,),
            Text(
                'Holbegram',
                style: TextStyle(
                  fontFamily: 'Billabong',
                  fontSize: 50.0
                ),
              ), 
          Image(
            image: AssetImage('assets/images/logo.webp'),
            height: 60.0,
            width: 80.0,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              SizedBox(height: 28.0,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                
                child: Text(
                  'Sign up to see photos and videos from your friends',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
              )),
              SizedBox(height: 24.0,),

    // Email
              TextFieldInput(
                controller: emailController,
                ispassword: false,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.0,),

    // Full Name
              TextFieldInput(
                controller: usernameController,
                ispassword: false,
                hintText: 'Full Name',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.0,),

    // Password
              TextFieldInput(
                controller: passwordController,
                ispassword: !_passwordVisible,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  alignment: Alignment.bottomLeft,
                  icon: Icon(
                    _passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off
                  ),
                  onPressed: () { setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                 }
                ),
              ),
              SizedBox(height: 28.0,),

    // Confirm Password
              TextFieldInput(
                controller: passwordConfirmController,
                ispassword: !_passwordVisible,
                hintText: 'Confirm Password',
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  alignment: Alignment.bottomLeft,
                  icon: Icon(
                    _passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off
                  ),
                  onPressed: () { setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                 }
                ),
              ),
              SizedBox(height: 28.0,),

    // Sign up Button
              SizedBox(
                height: 48.0,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(218, 226, 37, 24),)
                  ),
                  onPressed: () => {},
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),),),
              ),
              SizedBox( height: 24.0,),

              Flexible(
                flex: 0,
                child: Container()),
              
              Divider(thickness: 2.0,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account?"),
                    TextButton(
      // Navigate to LoginScreen when the button is pressed
                      onPressed: () => {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const LoginScreen()))
                      }, 
                      child: Text('Log in', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(218, 226, 37, 24)),))
                  ],
              )),
            ],),)
        ],),
      ),
    );
  }
}
