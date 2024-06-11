import 'dart:convert';


import 'package:http/http.dart';
import 'package:movie_app2/Repository/Api/api_client.dart';
import 'package:movie_app2/Repository/ModelClass/movie_model.dart';



class MovieApi {
  ApiClient apiClient = ApiClient();


  Future<Moviemodel> getMovie() async {
    String trendingpath = 'https://movies-api14.p.rapidapi.com/movies';
    var body = {

    };
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return Moviemodel.fromJson(jsonDecode(response.body));
  }
}