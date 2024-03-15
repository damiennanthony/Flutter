import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/screens/details_screen.dart';

class WatchedScreen extends StatefulWidget {
  const WatchedScreen({Key? key}) : super(key: key);

  @override
  _WatchedScreenState createState() => _WatchedScreenState();
}

class _WatchedScreenState extends State<WatchedScreen> {
  bool _sortAZ = false;

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Watched Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              setState(() {
                _sortAZ = !_sortAZ;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
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

          List<Movie> watchedMovies = documents
              .map((doc) => Movie(
                    title: doc['title'],
                    overView: doc['overview'],
                    releaseDate: doc['release_date'],
                    voteAverage: doc['vote_average'],
                    popularity: doc['popularity'],
                    posterPath: doc['poster_path'],
                    id: doc['id'],
                    backDropPath: doc['backdrop_path'],
                    originalTitle: doc['title'],
                  ))
              .toList();

          if (_sortAZ) {
            watchedMovies.sort((a, b) => a.title!.compareTo(b.title!));
          }

          if (watchedMovies.isEmpty) {
            return Center(child: Text('No watched movies yet.'));
          }

          return ListView.builder(
            itemCount: watchedMovies.length,
            itemBuilder: (context, index) {
              final movie = watchedMovies[index];
              return ListTile(
                title: Text(movie.title ?? 'Unknown Title'),
                subtitle:
                    Text(movie.overView ?? 'No overview available'),
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