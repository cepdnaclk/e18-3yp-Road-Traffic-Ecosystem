import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/map_screen.dart';
import 'package:flutter_auth/Screens/qr_code_scnner.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _auth = FirebaseAuth.instance;
  String uemail = " ";
  String upassword = " ";
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    print(_formKey.currentState!.validate());
    FocusScope.of(context).unfocus();
    final bool isValid = _formKey.currentState!.validate();
    print("karan");
    var authResult;
    print(_authData['email']);
    try {
      if (isValid) {
        _formKey.currentState!.save();

        authResult = await _auth.createUserWithEmailAndPassword(
            email: uemail.trim(), password: upassword.trim());

        print(uemail);
        print(upassword);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QRScanner()),
        );
      }
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
            validator: (value) {
              if (value!.isEmpty || !value.contains('@') || value == null) {
                return 'Invalid email!';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (value) {
              uemail = value!;
            },
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 240, 219, 205),
              hintText: "E-Mail",
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
              validator: (value) {
                if (value!.isEmpty || value.length < 5 || value == null) {
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
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: kActiveIconColor, elevation: 0),
            onPressed: _submit,
            child: Text("Sign Up karan".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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
