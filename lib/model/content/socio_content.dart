import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:video_player/video_player.dart';

part 'socio_content.g.dart';

enum SocioContentType {
  @JsonValue('CONTENT_TYPE_POST')
  CONTENT_TYPE_POST,
  @JsonValue('CONTENT_TYPE_STORY')
  CONTENT_TYPE_STORY,
  @JsonValue('CONTENT_TYPE_LOCATION')
  CONTENT_TYPE_LOCATION,
  @JsonValue('CONTENT_TYPE_UNKOWN')
  CONTENT_TYPE_UNKOWN
}

enum SocioMimeType {
  @JsonValue('MIME_TYPE_IMAGE')
  MIME_TYPE_IMAGE,
  @JsonValue('MIME_TYPE_VIDEO')
  MIME_TYPE_VIDEO,
  @JsonValue('MIME_TYPE_THOUGHT')
  MIME_TYPE_THOUGHT,
  @JsonValue('ARTEMIS_UNKNOWN')
  ARTEMIS_UNKNOWN
}

@JsonSerializable(
  explicitToJson: true,
)
class SocioContent {

  final String id;
  final String userId;
  @JsonKey(defaultValue: SocioContentType.CONTENT_TYPE_UNKOWN)
  final SocioContentType contentType;
  @JsonKey(defaultValue: 0)
  int? likeCount;
  @JsonKey(defaultValue: 0)
  final int? commentCount;
  final String? description;
  final String? profilePicture;
  @JsonKey(defaultValue: [])
  final List<ContentItem> contents;
  // final ContentLocation? locations;
  // @JsonKey(defaultValue: [])
  // final List<TaggedUser> taggedUsers;
  final String? userName;
  final String? textColor;
  final String? themeColor;
  final String? contentText;
  final String? fullName;
  final bool? turnOffComments;
  final bool? isMuted;
  bool? isLiked;
  // final PostVisibilityType? visibilityType;


  SocioContent({
    required this.id,
    required this.userId,
    required this.contentType,
    this.likeCount,
    this.commentCount,
    this.description,
    required this.contents,
    this.profilePicture,
    this.userName,
    this.textColor,
    this.themeColor,
    this.contentText,
    this.fullName,
    this.turnOffComments,
    this.isMuted,
    this.isLiked,

  });

  factory SocioContent.fromJson(Map<String, dynamic> json) => _$SocioContentFromJson(json);

  Map<String, dynamic> toJson() => _$SocioContentToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
)

class ContentItem {

  final String? artifactPath;
  @JsonKey(defaultValue: SocioMimeType.MIME_TYPE_IMAGE)
  final SocioMimeType? mimeType;
  final String? imageURL;
  final String? timeStamp;
  final String? uuid;
  final int? videoDuration;
  final bool? isLiked;

  ContentItem({
    this.artifactPath,
    this.isLiked,
    this.mimeType,
    this.imageURL,
    this.timeStamp,
    this.uuid,
    this.videoDuration,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) => _$ContentItemFromJson(json);

  Map<String, dynamic> toJson() => _$ContentItemToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  String filePath = '';

  @JsonKey(includeFromJson: false, includeToJson: false)
  late VideoPlayerController videoPlayerController;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late ValueNotifier<bool> audioValueNotifier;
}