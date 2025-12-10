import 'package:flutter/material.dart';
import '../../../../data/models/movie.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie?;
    
    return Scaffold(
      appBar: AppBar(title: Text(movie?.title ?? 'Detail')),
      body: Center(
        child: Text("Movie ID: ${movie?.id ?? 'N/A'}"),
      ),
    );
  }
}