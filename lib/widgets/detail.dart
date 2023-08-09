import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final String imdbId;
  DetailPage({required this.imdbId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MovieDetail? movie;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMovie().then((val)=>{

      setState((){
        movie=val;
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page"),),
      body: movie == null ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Text(movie!.title, style: TextStyle(fontSize: 32, color: Colors.blue,),textAlign: TextAlign.center,),
                SizedBox(height: 8,),
                Text("${movie!.year} - ${movie!.genre}"),
                SizedBox(height: 8,),
                Image.network(movie!.poster),
                SizedBox(height: 8,),
                Text(movie!.director),
                SizedBox(height: 8,),
                Text(movie!.actors),
                SizedBox(height: 8,),
                Text(movie!.released),
                SizedBox(height: 8,),
                Text(movie!.plot, textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ),
    );


  }

  Future<MovieDetail> fetchMovie() async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?i=${widget.imdbId}&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movie');
    }
  }
}
