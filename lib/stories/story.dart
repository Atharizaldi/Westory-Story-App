class Story {
  String? id, name, description, photoUrl, createdAt;

  Story({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      createdAt: json['createdAt'],
    );
  }
}
