import 'package:pokemon/model/Anime.dart';

import '../Data/anime_service.dart';

class HomeViewModel{

  Future<List<Anime>> getAnimeList() {
    final AnimeService animeService = AnimeService();
    return animeService.getAnimes();
  }
}