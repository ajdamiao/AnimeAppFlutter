import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Anime.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var urlAnime = Uri.parse("https://ghibliapi.herokuapp.com/films/");
  Anime animeHub = Anime();
  late Future<List<Anime>> animeList;

  @override
  void initState() {
    super.initState();
    animeList = fetchAnimeData();
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
      body: FutureBuilder<List<Anime>>(
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
                        builder: (BuildContext context) => Center (
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: SingleChildScrollView(
                                child: Container(
                                    width: 400,
                                    height: 600,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                                        color: Colors.white),
                                    child: SingleChildScrollView (
                                      child: Column (
                                        children: [
                                          const SizedBox(height: 10),
                                          Container(
                                            width: 300,
                                            height: 350,
                                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(anime.image.toString()))),
                                          ),
                                          Padding(padding: const EdgeInsets.all(4.0),
                                              child: Column(
                                                children: [
                                                  Text(anime.originalTitle.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                                  Text("(${anime.originalTitleRomanised.toString()})", style: const TextStyle(fontSize: 12),),
                                                  const SizedBox(height: 10,)
                                                ],
                                              )
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 24.0, left: 24.0),
                                            child: Text(anime.description.toString()),
                                          ),
                                          const SizedBox(height: 10,),
                                          ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black),
                                            onPressed: (){
                                              Navigator.of(context, rootNavigator: true).pop('dialog');},
                                            child: Text("Fechar"),
                                          ),
                                          const SizedBox(height: 20,)
                                        ],
                                      ),
                                    )
                                ),
                              )
                            )
                        )
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            height: 170,
                            width: 100,
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(anime.image.toString()))),
                          ),
                          SizedBox(width:100, child: Center(child: Text(anime.originalTitle.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),))),
                          const SizedBox(height: 10),
                          Text(anime.director.toString()),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
