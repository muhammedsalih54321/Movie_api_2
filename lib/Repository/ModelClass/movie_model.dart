
class Moviemodel {
    List<Movies>? movies;
    int? page;

    Moviemodel({this.movies, this.page});

    Moviemodel.fromJson(Map<String, dynamic> json) {
        if(json["movies"] is List) {
            movies = json["movies"] == null ? null : (json["movies"] as List).map((e) => Movies.fromJson(e)).toList();
        }
        if(json["page"] is num) {
            page = (json["page"] as num).toInt();
        }
    }

    static List<Moviemodel> fromList(List<Map<String, dynamic>> list) {
        return list.map((map) => Moviemodel.fromJson(map)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(movies != null) {
            _data["movies"] = movies?.map((e) => e.toJson()).toList();
        }
        _data["page"] = page;
        return _data;
    }

    Moviemodel copyWith({
        List<Movies>? movies,
        int? page,
    }) => Moviemodel(
        movies: movies ?? this.movies,
        page: page ?? this.page,
    );
}

class Movies {
    int? id;
    String? backdropPath;
    List<String>? genres;
    String? originalTitle;
    String? overview;
    String? posterPath;
    String? releaseDate;
    String? title;
    String? contentType;

    Movies({this.id, this.backdropPath, this.genres, this.originalTitle, this.overview, this.posterPath, this.releaseDate, this.title, this.contentType});

    Movies.fromJson(Map<String, dynamic> json) {
        if(json["_id"] is num) {
            id = (json["_id"] as num).toInt();
        }
        if(json["backdrop_path"] is String) {
            backdropPath = json["backdrop_path"];
        }
        if(json["genres"] is List) {
            genres = json["genres"] == null ? null : List<String>.from(json["genres"]);
        }
        if(json["original_title"] is String) {
            originalTitle = json["original_title"];
        }
        if(json["overview"] is String) {
            overview = json["overview"];
        }
        if(json["poster_path"] is String) {
            posterPath = json["poster_path"];
        }
        if(json["release_date"] is String) {
            releaseDate = json["release_date"];
        }
        if(json["title"] is String) {
            title = json["title"];
        }
        if(json["contentType"] is String) {
            contentType = json["contentType"];
        }
    }

    static List<Movies> fromList(List<Map<String, dynamic>> list) {
        return list.map((map) => Movies.fromJson(map)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["_id"] = id;
        _data["backdrop_path"] = backdropPath;
        if(genres != null) {
            _data["genres"] = genres;
        }
        _data["original_title"] = originalTitle;
        _data["overview"] = overview;
        _data["poster_path"] = posterPath;
        _data["release_date"] = releaseDate;
        _data["title"] = title;
        _data["contentType"] = contentType;
        return _data;
    }

    Movies copyWith({
        int? id,
        String? backdropPath,
        List<String>? genres,
        String? originalTitle,
        String? overview,
        String? posterPath,
        String? releaseDate,
        String? title,
        String? contentType,
    }) => Movies(
        id: id ?? this.id,
        backdropPath: backdropPath ?? this.backdropPath,
        genres: genres ?? this.genres,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        contentType: contentType ?? this.contentType,
    );
}