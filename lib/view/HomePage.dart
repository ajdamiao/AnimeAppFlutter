import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Anime.dart';
import '../model/Pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url = Uri.parse("https://pokeapi.co/api/v2/pokemon/");
  var urlAnime = Uri.parse("https://ghibliapi.herokuapp.com/films/");

  Pokemon pokeHub = Pokemon();
  Anime animeHub = Anime();
  late Future<List<Anime>> animeList;

  @override
  void initState() {
    super.initState();

    //fetchPokemonData();
    animeList = fetchAnimeData();
  }

  void fetchPokemonData() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);

    pokeHub = Pokemon.fromJson(decodedJson);
  }

  Future<List<Anime>> fetchAnimeData() async {
    var response = await http.get(urlAnime);


    List animesList = json.decode(response.body);
    return animesList.map((json) => Anime.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Anime"), backgroundColor: Colors.red,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: FutureBuilder<List<Anime>>(
            future: animeList,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 250,
                  mainAxisSpacing: 20,
                ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      Anime anime = snapshot.data![index];
                      return GestureDetector(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                                color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(anime.description.toString()),
                                ),
                              );
                            },
                          );
                        },
                        child: Card(
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                height: 170,
                                width: 100,
                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(anime.image.toString()))),
                              ),
                              SizedBox(width:100, child: Center(child: Text(anime.originalTitle.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),))),
                              SizedBox(height: 10,),
                              Text(anime.director.toString()),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){ fetchAnimeData(); },
        child: Icon(Icons.refresh),
        backgroundColor: Colors.red,
      ),
    );
  }
}
