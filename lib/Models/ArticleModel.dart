class Article {
  int id;
  String title;
  String author;
  String category;
  String content;
  String image;
  String imageUrl;
  String createdOn;

  Article(
      {this.id,
        this.title,
        this.author,
        this.category,
        this.content,
        this.image,
        this.imageUrl,
        this.createdOn});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    category = json['category'];
    content = json['content'];
    image = json['image'];
    imageUrl = json['image_url'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['category'] = this.category;
    data['content'] = this.content;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    data['created_on'] = this.createdOn;
    return data;
  }
}
