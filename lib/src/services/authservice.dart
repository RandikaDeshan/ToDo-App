import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/src/models/usermodel.dart';

class AuthService{
      final CollectionReference _userCollection = FirebaseFirestore.instance.collection("users");
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = GoogleSignIn();

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
          }
        }catch(error){
          print("Error : $error");
        }
      }

      Future<void> signInWithEmailAndPassword({required String email, required String password})async {
        try{
          await _auth.signInWithEmailAndPassword(email: email, password: password);
        }catch(error){
          print("Error : $error");
        }
      }

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

          final UserCredential userCredential = await _auth.signInWithCredential(credential);

          final User? user = userCredential.user;

          if(user != null){
            final UserModel newUser = UserModel(
                email: user.email ?? "No Email",
                password: "",
                userId: user.uid);

            final docRef = _userCollection.doc(user.uid);
            await docRef.set(newUser.toJson());
          }
        }catch(error){
          print("Error ; $error");
        }
      }

      Future<void> signOut() async {
        try {
          await _auth.signOut();
        } catch (error) {
          print("Error ; $error");
        }
      }

}