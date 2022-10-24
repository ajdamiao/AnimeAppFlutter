class Anime {
  String? id;
  String? title;
  String? originalTitle;
  String? originalTitleRomanised;
  String? image;
  String? movieBanner;
  String? description;
  String? director;
  String? producer;
  String? releaseDate;
  String? runningTime;
  String? rtScore;
  List<String>? people;
  List<String>? species;
  List<String>? locations;
  List<String>? vehicles;
  String? url;

  Anime(
      {this.id,
        this.title,
        this.originalTitle,
        this.originalTitleRomanised,
        this.image,
        this.movieBanner,
        this.description,
        this.director,
        this.producer,
        this.releaseDate,
        this.runningTime,
        this.rtScore,
        this.people,
        this.species,
        this.locations,
        this.vehicles,
        this.url});

  Anime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    originalTitle = json['original_title'];
    originalTitleRomanised = json['original_title_romanised'];
    image = json['image'];
    movieBanner = json['movie_banner'];
    description = json['description'];
    director = json['director'];
    producer = json['producer'];
    releaseDate = json['release_date'];
    runningTime = json['running_time'];
    rtScore = json['rt_score'];
    people = json['people'].cast<String>();
    species = json['species'].cast<String>();
    locations = json['locations'].cast<String>();
    vehicles = json['vehicles'].cast<String>();
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['original_title'] = this.originalTitle;
    data['original_title_romanised'] = this.originalTitleRomanised;
    data['image'] = this.image;
    data['movie_banner'] = this.movieBanner;
    data['description'] = this.description;
    data['director'] = this.director;
    data['producer'] = this.producer;
    data['release_date'] = this.releaseDate;
    data['running_time'] = this.runningTime;
    data['rt_score'] = this.rtScore;
    data['people'] = this.people;
    data['species'] = this.species;
    data['locations'] = this.locations;
    data['vehicles'] = this.vehicles;
    data['url'] = this.url;
    return data;
  }
}
