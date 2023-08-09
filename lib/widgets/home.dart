import 'package:flutter/material.dart';
import 'detail.dart';
import 'package:movie_app/models/movie_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _movies = [
    // {
    //   "Title": "Oppenheimer",
    //   "Year": "2023",
    //   "imdbID": "tt15398776",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMDBmYTZjNjUtN2M1MS00MTQ2LTk2ODgtNzc2M2QyZGE5NTVjXkEyXkFqcGdeQXVyNzAwMjU2MTY@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Oppenheimer",
    //   "Year": "1980",
    //   "imdbID": "tt0078037",
    //   "Type": "series",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BNDJmYTEyODAtMDgwMS00ZDU4LWEwYTYtOTQxYmQ2NTE5ZGY5XkEyXkFqcGdeQXVyNTEwNzU0NzY@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "The Trials of J. Robert Oppenheimer",
    //   "Year": "2008",
    //   "imdbID": "tt1559008",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BODVkZGI1MDYtYTBkYy00NDBhLWJhZGMtZGZiNWQ2MDI3YWRmXkEyXkFqcGdeQXVyNjc5NjEzNA@@._V1_SX300.jpg"
    // }
  ];
  var searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                // To be completed
                Expanded(
                    flex: 2,
                    child: TextField(
                      controller: searchEditingController,
                      decoration:
                          InputDecoration(hintText: "Enter movie to search"),
                    )),
                Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        onPressed: () {
                          // fetch the movies, retrive the results on val (List of Movies)
                          fetchMovies(searchEditingController.text).then((val)=>{
                            setState((){
                              _movies = val;
                            })
                          });


                        }, child: Text("Search me!")))
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _movies.length,
                  itemBuilder: (context, position) {
                    // To be completed
                    return ListTile(
                      title: Text(_movies[position].title),
                      subtitle: Text(
                          '${_movies[position].year} - ${_movies[position].type}'),
                      leading: Image.network(_movies[position].poster),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(imdbId: _movies[position].imdbId,)));
                      },
                    );
                  }),
            )
          ],
        ));
  }

  // Future -> Asynchronous process, the way you call it is using then
// If i am getting data from an Array, I replace Album with List oof Class
  // If i am getting data from an Object, I replace Album with Class
  // import class, http and dart convert
  Future<List<MovieSearch>> fetchMovies(searchText) async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s=$searchText&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieSearch.moviesFromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
