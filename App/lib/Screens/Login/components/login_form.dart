import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Welcome/home_screen.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String uemail = " ";
  String upassword = " ";
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    bool isValid = false;
    if (_formKey.currentState == null) {
      isValid = false;
      print("null karan");
    } else if (_formKey.currentState!.validate()) {
      isValid = true;
      print("true");
    }

    print(uemail);
    print("karan");

    var authResult;

    print(upassword);
    try {
      _formKey.currentState!.save();

      authResult = await _auth.signInWithEmailAndPassword(
          email: uemail.trim(), password: upassword.trim());
      print(uemail);
      print(upassword);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on PlatformException catch (err) {
      var message = "error irukkuda check your credential";
      if (err.message != null) message = err.message!;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            key: Key("email-field"),
            validator: (value) {
              if (value!.isEmpty || !value.contains('@') || value == null) {
                return 'Invalid email!';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kActiveIconColor,
            onSaved: (email) {
              uemail = email!;
            },
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 240, 219, 205),
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(
                  Icons.person,
                  color: kActiveIconColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              key: Key("password-field"),
              style: TextStyle(color: Colors.black),
              validator: (value) {
                print(value);
                if (value!.isEmpty || value.length < 5) {
                  print("Pilada");
                  return 'Password is too short!';
                }
              },
              onSaved: (value) {
                upassword = value!;
              },
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                fillColor: Color.fromARGB(255, 240, 219, 205),
                hintText: "Password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.lock,
                    color: kActiveIconColor,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forget Password?',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: kActiveIconColor),
              )
            ],
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: kActiveIconColor, elevation: 0),
              onPressed: _submit,
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
