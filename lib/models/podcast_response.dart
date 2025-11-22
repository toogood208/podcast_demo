

class LatestEpisodesResponse {
  final String message;
  final LatestEpisodesData data;

  LatestEpisodesResponse({
    required this.message,
    required this.data,
  });

  factory LatestEpisodesResponse.fromJson(Map<String, dynamic> json) {
    return LatestEpisodesResponse(
      message: json["message"],
      data: LatestEpisodesData.fromJson(json["data"]),
    );
  }
}


class LatestEpisodesData {
  final String message;
  final EpisodesList data;

  LatestEpisodesData({
    required this.message,
    required this.data,
  });

  factory LatestEpisodesData.fromJson(Map<String, dynamic> json) {
    return LatestEpisodesData(
      message: json["message"],
      data: EpisodesList.fromJson(json["data"]),
    );
  }
}


class EpisodesList {
  final List<Episode> episodes;

  EpisodesList({required this.episodes});

  factory EpisodesList.fromJson(Map<String, dynamic> json) {
    return EpisodesList(
      episodes: List<Episode>.from(
        json["data"].map((x) => Episode.fromJson(x)),
      ),
    );
  }
}


class Episode {
  final int id;
  final int podcastId;
  final String contentUrl;
  final String title;
  final String? season;
  final String? number;
  final String pictureUrl;
  final String description;
  final bool explicit;
  final int duration;
  final String createdAt;
  final String updatedAt;
  final int playCount;
  final int likeCount;
  final dynamic averageRating;
  final Podcast podcast;
  final String publishedAt;

  Episode({
    required this.id,
    required this.podcastId,
    required this.contentUrl,
    required this.title,
    required this.season,
    required this.number,
    required this.pictureUrl,
    required this.description,
    required this.explicit,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.playCount,
    required this.likeCount,
    required this.averageRating,
    required this.podcast,
    required this.publishedAt,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json["id"],
      podcastId: json["podcast_id"],
      contentUrl: json["content_url"],
      title: json["title"],
      season: json["season"],
      number: json["number"],
      pictureUrl: json["picture_url"],
      description: json["description"],
      explicit: json["explicit"],
      duration: json["duration"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      playCount: json["play_count"],
      likeCount: json["like_count"],
      averageRating: json["average_rating"],
      podcast: Podcast.fromJson(json["podcast"]),
      publishedAt: json["published_at"],
    );
  }
}


class Podcast {
  final int id;
  final int userId;
  final String title;
  final String author;
  final String categoryName;
  final String categoryType;
  final String pictureUrl;
  final String? coverPictureUrl;
  final String description;
  final dynamic embeddablePlayerSettings;
  final String createdAt;
  final String updatedAt;
  final Publisher publisher;

  Podcast({
    required this.id,
    required this.userId,
    required this.title,
    required this.author,
    required this.categoryName,
    required this.categoryType,
    required this.pictureUrl,
    required this.coverPictureUrl,
    required this.description,
    required this.embeddablePlayerSettings,
    required this.createdAt,
    required this.updatedAt,
    required this.publisher,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json["id"],
      userId: json["user_id"],
      title: json["title"],
      author: json["author"],
      categoryName: json["category_name"],
      categoryType: json["category_type"],
      pictureUrl: json["picture_url"],
      coverPictureUrl: json["cover_picture_url"],
      description: json["description"],
      embeddablePlayerSettings: json["embeddable_player_settings"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      publisher: Publisher.fromJson(json["publisher"]),
    );
  }
}


class Publisher {
  final int id;
  final String firstName;
  final String lastName;
  final String companyName;
  final String email;
  final String? profileImageUrl;
  final String createdAt;
  final String updatedAt;

  Publisher({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.email,
    required this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      companyName: json["company_name"],
      email: json["email"],
      profileImageUrl: json["profile_image_url"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }
}
