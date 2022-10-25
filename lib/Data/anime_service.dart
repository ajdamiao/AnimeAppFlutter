import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon/model/Anime.dart';

class AnimeService {

  final Uri urlAnime = Uri.parse("https://ghibliapi.herokuapp.com/films/");
  final http.Client client = http.Client();

  Future<List<Anime>> getAnimes() async {
    final response = await http.get(urlAnime);
    final body = json.decode(response.body);
    final animes = List<Map<String, dynamic>>.from(body);
    return animes.map((e) => Anime.fromJson(e)).toList();
  }
}