import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/watchedscreen.dart';
import 'package:flutter_application_1/screens/search_screen.dart';
import 'package:flutter_application_1/widgets/movie_slider.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/apicalls/apicalls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Home screen renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('AppBar title is displayed correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.text('MoviePal🎥'), findsOneWidget);
  });

  testWidgets('Search button is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Logout button is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });

  testWidgets('Watched Movies FAB is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.byIcon(Icons.movie), findsOneWidget);
  });

  // Additional tests

  testWidgets('Tap on search button navigates to search screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(find.byType(SearchScreen), findsOneWidget);
  });

  testWidgets('Tap on logout button signs out the user', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'rememberMe': true});
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('rememberMe'), false);
  });

  testWidgets('Tap on FAB navigates to watched screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    await tester.tap(find.byIcon(Icons.movie));
    await tester.pumpAndSettle();
    expect(find.byType(WatchedScreen), findsOneWidget);
  });

  // Function unit tests

  test('Sign out sets rememberMe to false in SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({'rememberMe': true});
    final homeScreen = HomeScreen();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('rememberMe'), false);
  });

  test('API call for trending movies returns a non-null list', () async {
    final api = Api();
    final trendingMovies = await api.getTrendingMovies();
    expect(trendingMovies, isNotNull);
    expect(trendingMovies, isInstanceOf<List<Movie>>());
  });
}
