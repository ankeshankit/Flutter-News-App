
class NewsModel {
  String? status;
  int? totalResults;
  List<Results>? results;
  String? nextPage;

  NewsModel({
    this.status,
    this.totalResults,
    this.results,
    this.nextPage,
  });

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];

    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }

    nextPage = json['nextPage'];
  }
}

class Results {
  String? articleId;
  String? title;
  String? description;
  String? imageUrl;
  String? link;
  String? sourceName;
  String? pubDate;

  Results({
    this.articleId,
    this.title,
    this.description,
    this.imageUrl,
    this.link,
    this.sourceName,
    this.pubDate,
  });

  Results.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['image_url'];
    link = json['link'];
    sourceName = json['source_name'];
    pubDate = json['pubDate'];
  }
}