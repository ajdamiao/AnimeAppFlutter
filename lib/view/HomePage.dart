import 'package:flutter/material.dart';
import 'package:pokemon/Data/anime_service.dart';
import 'package:pokemon/viewmodel/home_view_model.dart';

import '../model/Anime.dart';

class HomePage extends StatelessWidget {
  final AnimeService animeService = AnimeService();
  final HomeViewModel homeViewModel = HomeViewModel();
  HomePage({Key? key}) : super(key: key);

  void _showAnimeInfo(BuildContext context, Anime anime) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Anime"), backgroundColor: Colors.red,),
      body: FutureBuilder<List<Anime>>(
        future: homeViewModel.getAnimeList(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 250,
              mainAxisSpacing: 0,
            ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  Anime anime = snapshot.data![index];
                  return GestureDetector(
                    onTap: (){ _showAnimeInfo(context, anime); },
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
            return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

