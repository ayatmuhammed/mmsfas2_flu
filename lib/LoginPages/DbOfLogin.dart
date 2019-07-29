import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Sign Out");
}






//import 'package:firebase_database/firebase_database.dart';
////i want to sent the information of users as widget
//import 'package:flutter/widgets.dart';
//// i add the users which i want to send  them to database in class
//class UserToDatabase{
//  //function to help me to import it from any where
//  addNewUser(user,context){
//    FirebaseDatabase.instance.reference().child('users').push().set({
//      'email':user.email,
//      'uid':user.uid,
//
//      //i use then to do many thinks such as move it to another page
//    }).then((value){
//      Navigator.of(context).pop();
//      Navigator.of(context).pushReplacementNamed('/home');
//    }).catchError((e){
//      print(e);
//    });
//  }
//
//
//}