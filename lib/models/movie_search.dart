
// 1 ) Create the class
class MovieSearch {
  // 2) Create the properties of the class (what data you want to show on UI)
  final String title;
  final String year;
  final String type;
  final String poster;
  final String imdbId;

  // 3) Create the constructor of the class

MovieSearch({required this.title, required this.year, required this.type, required this.poster, required this.imdbId});

// 4) Create JSON to Object transformer

factory MovieSearch.fromJson(Map<String,dynamic> json){
  return
    MovieSearch(title: json["Title"], year: json["Year"], type: json["Type"],
        poster: json["Poster"], imdbId: json["imdbID"]);
}

// 5) Array of JSON to List of Object transformer

  static List<MovieSearch> moviesFromJson(dynamic json ){
    var searchResult = json["Search"];
    List<MovieSearch> results = new List.empty(growable: true);

    if (searchResult != null){

      searchResult.forEach((v)=>{
        results.add(MovieSearch.fromJson(v))
      });
      return results;
    }
    return results;
  }



}