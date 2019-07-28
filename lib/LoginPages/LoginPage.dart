import 'package:flutter/material.dart';
void main() => runApp(new LoginPage());

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _PassWord;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Form Validation'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: FormUI(),
            ),
          ),
        ),
      ),
    );
  }

// Here is our Form UI
  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val) {
            _email = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Password'),
          keyboardType: TextInputType.phone,
          validator: validatePassWord,
          onSaved: (String val) {
            _PassWord = val;
          },
        ),

        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: _validateInputs,
          child: new Text('Validate'),
        )
      ],
    );
  }

  String validateName(String value) {
    if (value.length < 8)
      return 'Name must be more than 7 charater';
    else
      return null;
  }

  String validatePassWord(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 6)
      return 'Mobile Number must be of 6 digit';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }


//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//
//
//class LoginPage extends StatefulWidget {
//  @override
//  _LoginPageState createState() => _LoginPageState();
//}
//
//class _LoginPageState extends State<LoginPage> {
//  TextEditingController _emailController = new TextEditingController();
//  TextEditingController _passWordController = new TextEditingController();
//  final formKey = GlobalKey<FormState>();
//  final scaffoldKey = GlobalKey<ScaffoldState>();
//  bool _autoValidate = false;
////
////  String _email;
////  String _password;
////
////  void _submitCommand() {
////    final form = formKey.currentState;
////
////    if (form.validate()) {
////      form.save();
////
////      // Email & password matched our validation rules
////      // and are saved to _email and _password fields.
////      _loginCommand();
////    }
////  }
//
////  void _loginCommand() {
////    // This is just a demo, so no actual login here.
////    final snackbar = SnackBar(
////      content: Text('Email: $_email, password: $_password'),
////    );
//
////    scaffoldKey.currentState.showSnackBar(snackbar);
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: scaffoldKey,
//      appBar: AppBar(
//        backgroundColor: Colors.indigo,
//        title: Text('sign in'),
//      ),
//      body: Padding(
//        padding: const EdgeInsets.all(16.0),
//        child: Form(
//          autovalidate: _autoValidate,
//          key: formKey,
//
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//
//              TextFormField(
//                decoration: InputDecoration(icon: Icon(Icons.email,color: Colors.indigo,)),
//                keyboardType: TextInputType.emailAddress ,
//                controller: _emailController,
//              ),
//
//              TextFormField(
//                decoration: InputDecoration(icon: Icon(Icons.lock,color: Colors.indigo,)),
//                keyboardType: TextInputType.number,
//                controller: _passWordController,
//              ),
//             MaterialButton(
//                onPressed: (){
//                  _validateInputs();
////
////                  Navigator.push(
////                    context, MaterialPageRoute(
////                    builder:
////                        (context) =>Homepage(),
////                  ),
////                  );
////                  FirebaseAuth.instance.createUserWithEmailAndPassword(
////                      email: _emailController.text, password: _passWordController.text).then((signedUser){
////                    UserToDatabase().addNewUser(signedUser, context);
////
////                  }
////                  ).catchError((e){
////                    print(e);
////                  });
//                },
//
//               // _submitCommand,
//                child: Text('Sign in', style: TextStyle(color: Colors.white)
//                ),
//               color: Colors.indigo,
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//  void _validateInputs() {
//    if (formKey.currentState.validate()) {
////    If all data are correct then save data to out variables
//      formKey.currentState.save(
//
//      );
//    } else {
////    If all data are not valid then start auto validation.
//      setState(() {
//        _autoValidate = true;
//      });
//    }
//  }
//
//
//}
}