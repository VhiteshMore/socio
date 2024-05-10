// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socio_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocioContent _$SocioContentFromJson(Map<String, dynamic> json) => SocioContent(
      id: json['id'] as String,
      userId: json['userId'] as String,
      contentType:
          $enumDecodeNullable(_$SocioContentTypeEnumMap, json['contentType']) ??
              SocioContentType.CONTENT_TYPE_UNKOWN,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      contents: (json['contents'] as List<dynamic>?)
              ?.map((e) => ContentItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      profilePicture: json['profilePicture'] as String?,
      userName: json['userName'] as String?,
      textColor: json['textColor'] as String?,
      themeColor: json['themeColor'] as String?,
      contentText: json['contentText'] as String?,
      fullName: json['fullName'] as String?,
      turnOffComments: json['turnOffComments'] as bool?,
      isMuted: json['isMuted'] as bool?,
      isLiked: json['isLiked'] as bool?,
    );

Map<String, dynamic> _$SocioContentToJson(SocioContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'contentType': _$SocioContentTypeEnumMap[instance.contentType]!,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'description': instance.description,
      'profilePicture': instance.profilePicture,
      'contents': instance.contents.map((e) => e.toJson()).toList(),
      'userName': instance.userName,
      'textColor': instance.textColor,
      'themeColor': instance.themeColor,
      'contentText': instance.contentText,
      'fullName': instance.fullName,
      'turnOffComments': instance.turnOffComments,
      'isMuted': instance.isMuted,
      'isLiked': instance.isLiked,
    };

const _$SocioContentTypeEnumMap = {
  SocioContentType.CONTENT_TYPE_POST: 'CONTENT_TYPE_POST',
  SocioContentType.CONTENT_TYPE_STORY: 'CONTENT_TYPE_STORY',
  SocioContentType.CONTENT_TYPE_LOCATION: 'CONTENT_TYPE_LOCATION',
  SocioContentType.CONTENT_TYPE_UNKOWN: 'CONTENT_TYPE_UNKOWN',
};

ContentItem _$ContentItemFromJson(Map<String, dynamic> json) => ContentItem(
      artifactPath: json['artifactPath'] as String?,
      isLiked: json['isLiked'] as bool?,
      mimeType: $enumDecodeNullable(_$SocioMimeTypeEnumMap, json['mimeType']) ??
          SocioMimeType.MIME_TYPE_IMAGE,
      imageURL: json['imageURL'] as String?,
      timeStamp: json['timeStamp'] as String?,
      uuid: json['uuid'] as String?,
      videoDuration: (json['videoDuration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContentItemToJson(ContentItem instance) =>
    <String, dynamic>{
      'artifactPath': instance.artifactPath,
      'mimeType': _$SocioMimeTypeEnumMap[instance.mimeType],
      'imageURL': instance.imageURL,
      'timeStamp': instance.timeStamp,
      'uuid': instance.uuid,
      'videoDuration': instance.videoDuration,
      'isLiked': instance.isLiked,
    };

const _$SocioMimeTypeEnumMap = {
  SocioMimeType.MIME_TYPE_IMAGE: 'MIME_TYPE_IMAGE',
  SocioMimeType.MIME_TYPE_VIDEO: 'MIME_TYPE_VIDEO',
  SocioMimeType.MIME_TYPE_THOUGHT: 'MIME_TYPE_THOUGHT',
  SocioMimeType.ARTEMIS_UNKNOWN: 'ARTEMIS_UNKNOWN',
};
