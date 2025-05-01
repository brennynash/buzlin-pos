import '../models.dart';

class ShopCommentsData {
  int? id;
  int? reviewableId;
  String? reviewableType;
  int? assignableId;
  String? assignableType;
  int? rating;
  String? comment;
  String? img;
  bool? ordered;
  bool? addedReview;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserData? user;

  ShopCommentsData({
    this.id,
    this.reviewableId,
    this.reviewableType,
    this.assignableId,
    this.assignableType,
    this.rating,
    this.comment,
    this.img,
    this.ordered,
    this.addedReview,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  ShopCommentsData copyWith({
    int? id,
    int? reviewableId,
    String? reviewableType,
    int? assignableId,
    String? assignableType,
    int? rating,
    String? comment,
    String? img,
    bool? ordered,
    bool? addedReview,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserData? user,
  }) =>
      ShopCommentsData(
        id: id ?? this.id,
        reviewableId: reviewableId ?? this.reviewableId,
        reviewableType: reviewableType ?? this.reviewableType,
        assignableId: assignableId ?? this.assignableId,
        assignableType: assignableType ?? this.assignableType,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        img: img ?? this.img,
        ordered: ordered ?? this.ordered,
        addedReview: addedReview ?? this.addedReview,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
      );

  factory ShopCommentsData.fromJson(Map<String, dynamic> json) =>
      ShopCommentsData(
        id: json["id"],
        reviewableId: json["reviewable_id"],
        reviewableType: json["reviewable_type"],
        assignableId: json["assignable_id"],
        assignableType: json["assignable_type"],
        rating: json["rating"],
        comment: json["comment"],
        img: json["img"],
        ordered: json["ordered"],
        addedReview: json["added_review"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reviewable_id": reviewableId,
        "reviewable_type": reviewableType,
        "assignable_id": assignableId,
        "assignable_type": assignableType,
        "rating": rating,
        "comment": comment,
        "img": img,
        "ordered": ordered,
        "added_review": addedReview,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}
