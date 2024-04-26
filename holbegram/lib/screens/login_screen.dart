// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/screens/signup_screen.dart';
import 'package:holbegram/widgets/text_field.dart';
import 'package:holbegram/screens/home_screen.dart';

// Stateful widgets can change over time
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // ignore: prefer_final_fields
  bool _passwordVisible = true;
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
          SizedBox(
            height: 28.0),
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
              TextFieldInput(
                controller: emailController,
                ispassword: false,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.0,),
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
              SizedBox(
                height: 48.0,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(218, 226, 37, 24),)
                  ),
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    String result = await AuthMethode().login(email: email, password: password);
                      if (result == 'success' && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login'),),);
                        // Home is not available, so a dummy Home was created
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home(),),);
                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed: $result'),),);
                      }
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(color: Colors.white),),),
              ),
              SizedBox( height: 24.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Forgot your login details? '),
                  Text('Get help logging in', style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
              Flexible(
                flex: 0,
                child: Container()),
              SizedBox(height: 24.0,),
              Divider(thickness: 2.0,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account"),
                    TextButton(
      // Navigate to SignScreen when the button is pressed
                      onPressed: () => {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => SignUp()))
                      }, 
                      child: Text('Sign up', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(218, 226, 37, 24)),))
                  ],
              )),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Flexible(child: Divider(thickness: 2,)),
                  Text(" OR "),
                  Flexible(child: Divider(thickness: 2,)),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network('https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                  width:40.0, height:40.0,),
                  Text('Sign in with Google')
                ],
              )
            ],),)
        ],),
      ),
    );
  }
}
