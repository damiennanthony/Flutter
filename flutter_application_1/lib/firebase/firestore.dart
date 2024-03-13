import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/movie.dart';

// Function to save user information to Firestore
Future<void> saveUserInfoToFirestore(String email) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Reference to the users collection in Firestore
      CollectionReference<Map<String, dynamic>> users =
          FirebaseFirestore.instance.collection('users');

      // Add a new document with a generated ID
      await users.doc(user.uid).set({
        'email': email,
        // You can add more fields as per your requirement
      });
    } else {
      print('User is not signed in.');
    }
  } catch (e) {
    print('Error saving user information: $e');
  }
}

Future<void> saveMovieDetailsToFirestore(String userId, Movie movie, String listType) async {
  try {
    // Reference to the user's document in the users collection
    DocumentReference<Map<String, dynamic>> userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Reference to the appropriate subcollection within the user's document based on listType
    CollectionReference<Map<String, dynamic>> movies =
        userDocRef.collection(listType);

    // Add a new document with a generated ID
    await movies.add({
      'title': movie.title,
      'overview': movie.overView,
      'release_date': movie.releaseDate,
      'vote_average': movie.voteAverage,
      'popularity': movie.popularity,
      'poster_path': movie.posterPath,
      'id':movie.id,
      'backdrop_path':movie.backDropPath,
      'original_title':movie.originalTitle
      
    });
  } catch (e) {
    print('Error saving movie details: $e');
  }
}