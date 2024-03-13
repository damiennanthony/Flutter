import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/screens/details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late Future<List<Movie>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchResults = Future.value([]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Movie>> _searchMoviesAndShows(String query) async {
    final List<Movie> searchResults = [];

    // Search movies by title
    final movieResponse = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/search/movie?query=$query&api_key=${Constants.apiKey}',
      ),
    );

    // Search TV shows by title
    final tvShowResponse = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/search/tv?query=$query&api_key=${Constants.apiKey}',
      ),
    );

    // Search movies and TV shows by actor's name
    final actorResponse = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/search/person?query=$query&api_key=${Constants.apiKey}',
      ),
    );

    if (movieResponse.statusCode == 200) {
      final Map<String, dynamic> movieData = jsonDecode(movieResponse.body);
      final List<dynamic> movieResults = movieData['results'] ?? [];
      searchResults.addAll(movieResults.map((json) => Movie.fromJson(json)).toList());
    }

    if (tvShowResponse.statusCode == 200) {
      final Map<String, dynamic> tvShowData = jsonDecode(tvShowResponse.body);
      final List<dynamic> tvShowResults = tvShowData['results'] ?? [];
      searchResults.addAll(tvShowResults.map((json) => Movie.fromJson(json)).toList());
    }

    if (actorResponse.statusCode == 200) {
      final Map<String, dynamic> actorData = jsonDecode(actorResponse.body);
      final List<dynamic> actorResults = actorData['results'] ?? [];
      for (var actor in actorResults) {
        final actorId = actor['id'];
        final moviesResponse = await http.get(
          Uri.parse(
            'https://api.themoviedb.org/3/person/$actorId/movie_credits?api_key=${Constants.apiKey}',
          ),
        );
        if (moviesResponse.statusCode == 200) {
          final Map<String, dynamic> moviesData = jsonDecode(moviesResponse.body);
          final List<dynamic> movies = moviesData['cast'] ?? [];
          searchResults.addAll(movies.map((json) => Movie.fromJson(json)).toList());
        }
      }
    }

    return searchResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search movies, TV shows, or actors...',
          ),
          onChanged: (query) {
            setState(() {
              _searchResults = _searchMoviesAndShows(query);
            });
          },
        ),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return ListTile(
                  leading: movie.posterPath.isNotEmpty
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                          width: 50,
                        )
                      : Container(
                          width: 50,
                          height: 75,
                          color: Colors.grey,
                          child: Icon(Icons.movie),
                        ),
                  title: Text(movie.title ?? 'Unknown Title'),
                  subtitle: Text('Rating: ${movie.voteAverage.toString()}'),
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
          } else {
            return Center(
              child: Text('No results found'),
            );
          }
        },
      ),
    );
  }
}