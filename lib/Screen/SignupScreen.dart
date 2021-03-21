import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/LocalData/ShareManager.dart';
import 'package:todo/Value/ValidString.dart';

class SignupScreen extends StatefulWidget {
  final routeName = "signUpScreen";
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final regEmail = new RegExp(validEmail);

  var isHidden = true;
  var isLoding = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    _title(),
                    _emailField(),
                    _passwordField(),
                    _signUpButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
        _loder()
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05),
      child: const Text(
        "TODO",
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          hintText: "Email Address",
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (value) {
          if (value != null &&
              (value.trim().isEmpty || !regEmail.hasMatch(value.trim()))) {
            return "Please Enter Valid Email-Address";
          } else
            return null;
        },
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: _passwordController,
        obscureText: isHidden,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          suffixIcon: GestureDetector(
              onTap: onClickChange,
              child: Icon(
                isHidden ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).primaryColor,
              )),
          filled: true,
          fillColor: Colors.grey[200],
          hintText: "Password",
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        validator: (value) {
          if (value != null &&
              (value.trim().isEmpty || value.trim().length < 6)) {
            return "Password must containe atleast 6 character";
          } else
            return null;
        },
      ),
    );
  }

  Widget _signUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MaterialButton(
          shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).primaryColor,
          height: 50,
          minWidth: double.infinity,
          child: Text(
            "SIGNUP",
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            signUp();
          }),
    );
  }

  Widget _loder() {
    return Visibility(
      visible: isLoding,
      child: Opacity(
        opacity: 0.7,
        child: Container(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  // Functions 

  void onTextClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => SignupScreen()));
  }

  void onClickChange() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  void showLoding() {
    setState(() {
      isLoding = !isLoding;
    });
  }

  void signUp() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      showLoding();
      final user = await ShareManager.getUserDetails();
      if (user.email == _emailController.text.trim() &&
          user.password == _passwordController.text.trim()) {
        showLoding();
        Fluttertoast.showToast(msg: "User already exist");
      } else {
        await ShareManager.setUserDetails(
            _emailController.text.trim(), _passwordController.text.trim());
        showLoding();
        Fluttertoast.showToast(msg: "Successfully registered");
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
