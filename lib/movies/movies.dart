import 'package:cpmoviemaker/movies/movies_list.dart';
import 'package:cpmoviemaker/movies/movies_viewmodel.dart';
import 'package:cpmoviemaker/navigation.dart';
import 'package:flutter/material.dart';
import 'package:cpmoviemaker/models/movie.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  final MoviesViewModel _viewModel;
  final String _title;

  MoviesScreen(this._viewModel, this._title);

  @override
  _MoviesScreenState createState() => _MoviesScreenState(_viewModel, _title);
}

class _MoviesScreenState extends State<MoviesScreen>
    implements MovieClickListener {
  final MoviesViewModel viewModel;
  final String title;

  _MoviesScreenState(this.viewModel, this.title);

  @override
  void initState() {
    super.initState();
    viewModel.fetchMovies();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  void onMovieClicked(Movie movie) {
    navigateToPreview(context, movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
      ),
      body: Consumer<MoviesViewModel>(
        builder: (_, __, ___) => MoviesList(this, viewModel.movies),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToCreation(context);
        },
        tooltip: "Create a new movie",
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
