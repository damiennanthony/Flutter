import 'dart:convert';

import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:http/http.dart' as http;

class Api{
  static const _trendingUrl = 
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  static const _topRatedUrl = 
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';

  static const _upcomingUrl = 
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';

  
  static const _bestMoviesThisYearUrl = 
      'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&primary_release_year=2023&sort_by=vote_average.desc';

  

  static const _highestGrossingUrl = 
      'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&sort_by=revenue.desc';


  static const _childrenFriendlyMoviesUrl = 
      'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&with_genres=16,10751,14,12';

  static const _popularTvShowsUrl = 
      'https://api.themoviedb.org/3/discover/tv?api_key=${Constants.apiKey}&&sort_by=popularity.desc';
  




  Future<List<Movie>> getTrendingMovies() async{
    final response = await http.get(Uri.parse(_trendingUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else{
      throw Exception('Something happened');
    }

  }
  
  Future<List<Movie>> getTopRatedMovies() async{
    final response = await http.get(Uri.parse(_topRatedUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else{
      throw Exception('Something happened');
    }

  }

  Future<List<Movie>> getUpcomingMovies() async{
    final response = await http.get(Uri.parse(_upcomingUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else{
      throw Exception('Something happened');
    }

  } 

   Future<List<Movie>> getBestMoviesThisYear() async{
    final response = await http.get(Uri.parse(_bestMoviesThisYearUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else{
      throw Exception('Something happened');
    }

  }

  Future<List<Movie>> getHighestGrossingMovies() async{
    final response = await http.get(Uri.parse( _highestGrossingUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else{
      throw Exception('Something happened');
    }

  }

   Future<List<Movie>> getChildrenFriendlyMovies() async{
    final response = await http.get(Uri.parse( _childrenFriendlyMoviesUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else{
      throw Exception('Something happened');
    }

  }

  Future<List<Movie>> getPopularTvShows() async{
    final response = await http.get(Uri.parse( _popularTvShowsUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else{
      throw Exception('Something happened');
    }

  }
   
}