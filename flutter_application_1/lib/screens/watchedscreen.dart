import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/screens/details_screen.dart';

class WatchedScreen extends StatelessWidget {
  
  
  const WatchedScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '' ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Watched Movies'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('watched')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data!;
          final documents = data.docs;
          if (documents.isEmpty) {
            return Center(child: Text('No watched movies yet.'));
          }
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final movieData = documents[index].data();
              final movie = Movie(
                title: movieData['title'],
                overView: movieData['overview'],
                releaseDate: movieData['release_date'] ,
                voteAverage: movieData['vote_average'] ,
                popularity: movieData['popularity'] , 
                posterPath: movieData['poster_path'],
                id: movieData['id'],
                backDropPath: movieData['backdrop_path'] ,
                originalTitle: movieData['title'],
              );
              return ListTile(
                title: Text(movie.title ?? 'Unknown Title'),
                subtitle: Text(movie.overView ?? 'No overview available'),
                leading: movie.posterPath.isNotEmpty
                    ? Image.network(
                        '${Constants.imagePath}${movie.posterPath}',
                        width: 50,
                        height: 75,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 50,
                        height: 75,
                        color: Colors.grey,
                        child: Icon(Icons.movie),
                      ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(movie: movie),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
