class MovieDetail{

  final String title;
  final String year;
  final String released;
  final String runtime;
  final String genre;
  final String plot;
  final String actors;
  final String poster;
  final String director;

  MovieDetail({required this.title, required this.year, required this.released,
  required this.runtime, required this.genre, required this.plot, required this.actors,
  required this.poster, required this.director});

  factory MovieDetail.fromJson(Map<String,dynamic> json){
    return MovieDetail(
        title: json["Title"],
        year: json["Year"],
        released: json["Released"],
        runtime: json["Runtime"],
        genre: json["Genre"],
        plot: json["Plot"],
        actors: json["Actors"],
        poster: json["Poster"],
        director: json["Director"]);
  }
}