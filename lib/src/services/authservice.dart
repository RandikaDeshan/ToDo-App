
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/src/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
      final CollectionReference _userCollection = FirebaseFirestore.instance.collection("users");
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = GoogleSignIn();


      // register user with email and password and send user data to firestore
      Future<void> registerUser(UserModel user)async{
        try{
          final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
              email: user.email,
              password: user.password);

          final userId = userCredential.user?.uid;

          if(userId != null){
          final userRef = _userCollection.doc(userId);
          final userMap = user.toJson();
          userMap['userId'] = userId;
          await userRef.set(userMap);

          // save user details in SharedPreferences
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setStringList(userId, [user.email,'','About']);
          }
        }catch(error){
          print("Error : $error");
        }
      }


      // sign in with email and password
      Future<void> signInWithEmailAndPassword({required String email, required String password})async {
        try{
          await _auth.signInWithEmailAndPassword(email: email, password: password);

          // get the signed user
          final user = FirebaseAuth.instance.currentUser;

          // save user details in SharedPreferences
          // if already saved data in SharedPreferences this not happen
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final List<String>? users = preferences.getStringList(user!.uid);
          if(users == null){
            await preferences.setStringList(user.uid, [email,'','About']);
          }

        }catch(error){
          print("Error : $error");
        }
      }


      // google sign in
      Future<void> signInWithGoogle()async{
        try{
          final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
          if(googleUser == null){
            return;
          }

          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
          );

          // store user details in firestore
          final UserCredential userCredential = await _auth.signInWithCredential(credential);

          final User? user = userCredential.user;

          if(user != null){
            final UserModel newUser = UserModel(
                email: user.email ?? "No Email",
                password: "",
                userId: user.uid);

            final docRef = _userCollection.doc(user.uid);
            await docRef.set(newUser.toJson());

            // store user details in SharedPreferences
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.setStringList(user.uid, [user.displayName ?? '',user.photoURL ?? '','About']);
          }
        }catch(error){
          print("Error ; $error");
        }
      }


      // sign out
      Future<void> signOut() async {
        try {
          await _auth.signOut();
        } catch (error) {
          print("Error ; $error");
        }
      }


      // get user details from SharedPreferences by user id
      Future<List<String>?> getUserDetails(String userId)async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final List<String>? users = preferences.getStringList(userId);
        return users;
      }


      // update user details in SharedPreferences
      Future<void> updateUsername(String userId, String username,String image, String about)async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setStringList(userId, [username,image,about]);
      }
}