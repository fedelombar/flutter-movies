class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  int gender;
  int id;
  String name;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  Actor({
    this.gender,
    this.id,
    this.name,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.intra-tp.com%2Fequipo%2Fno-avatar%2F&psig=AOvVaw2EYvPm0gvru_tKdO625KF_&ust=1611865837933000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJDb4qf6vO4CFQAAAAAdAAAAABAD';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
