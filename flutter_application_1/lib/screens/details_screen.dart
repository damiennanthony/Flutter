import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/widgets/back_button.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool isWatched=false;

  @override
  void initState() {
    super.initState();
    // Check if the movie is already marked as watched
    checkIfWatched();
  }

  Future<void> checkIfWatched() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    bool watched = await isMovieWatched(userId, widget.movie);
    setState(() {
      isWatched = watched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: const BackBtn(),
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.movie.title,
                style: GoogleFonts.belleza(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  '${Constants.imagePath}${widget.movie.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    'Overview',
                    style: GoogleFonts.openSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.movie.overView,
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                    //textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Release date: ',
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.movie.releaseDate,
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Rating:',
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                '${widget.movie.voteAverage.toStringAsFixed(1)}/10',
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      String userId =
                          FirebaseAuth.instance.currentUser?.uid ?? '';
                      if (isWatched) {
                        await removeMovieFromWatched(userId, widget.movie);
                      } else {
                        await saveMovieDetailsToFirestore(
                            userId, widget.movie, 'watched');
                      }
                      // Toggle isWatched state
                      setState(() {
                        isWatched = !isWatched;
                      });
                    },
                    child: Text(isWatched ? 'Remove from Watched' : 'Mark as Watched'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> isMovieWatched(String userId, Movie movie) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> movieDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('watched')
        .where('id', isEqualTo: movie.id)
        .get()
        .then((snapshot) => snapshot.docs.first);

    return movieDoc.exists;
  } catch (e) {
    print('Error checking if movie is watched: $e');
    return false;
  }
}

Future<void> removeMovieFromWatched(String userId, Movie movie) async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('watched')
        .where('id', isEqualTo: movie.id)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      await doc.reference.delete();
    }
  } catch (e) {
    print('Error removing movie from watched: $e');
  }
}
