import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class TribeModel {
  final String id;
  final String tribeName;
  final String description;
  final String avatar;
  final String locale;
  final String ownerId;
  final String status;
  final List<String> members;
  final int maxMembers;
  final int createdAt;
  final int updatedAt;

  TribeModel({
    this.id,
    this.tribeName,
    this.description,
    this.avatar,
    this.locale,
    this.ownerId,
    this.status,
    this.members,
    this.maxMembers,
    this.createdAt,
    this.updatedAt,
  });

  TribeModel.generate({
    String tribeName,
    String ownerId,
    String description,
    String locale,
  })  : id = Uuid().v4(),
        tribeName = tribeName ?? 'My tribe',
        description = description ?? 'Basic description',
        locale = locale ?? 'en',
        avatar = '',
        ownerId = ownerId ?? '',
        status = 'enabled',
        members = [ownerId],
        maxMembers = 20,
        createdAt = DateTime.now().millisecondsSinceEpoch,
        updatedAt = DateTime.now().millisecondsSinceEpoch;

  TribeModel copyWith({
    String id,
    String tribeName,
    String description,
    String avatar,
    String locale,
    String ownerId,
    String status,
    List<String> members,
    int maxMembers,
    int createdAt,
    int updatedAt,
  }) {
    return TribeModel(
      id: id ?? this.id,
      tribeName: tribeName ?? this.tribeName,
      description: description ?? this.description,
      avatar: avatar ?? this.avatar,
      locale: locale ?? this.locale,
      ownerId: ownerId ?? this.ownerId,
      status: status ?? this.status,
      members: members ?? this.members,
      maxMembers: maxMembers ?? this.maxMembers,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TribeModel &&
        o.id == id &&
        o.tribeName == tribeName &&
        o.description == description &&
        o.avatar == avatar &&
        o.locale == locale &&
        o.ownerId == ownerId &&
        o.status == status &&
        listEquals(o.members, members) &&
        o.maxMembers == maxMembers &&
        o.createdAt == createdAt &&
        o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tribeName.hashCode ^
        description.hashCode ^
        avatar.hashCode ^
        locale.hashCode ^
        ownerId.hashCode ^
        status.hashCode ^
        members.hashCode ^
        maxMembers.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'TribeModel(id: $id, tribeName: $tribeName, description: $description, avatar: $avatar, locale: $locale, ownerId: $ownerId, status: $status, members: $members, maxMembers: $maxMembers, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'tribeName': tribeName,
      'description': description,
      'avatar': avatar,
      'locale': locale,
      'ownerId': ownerId,
      'status': status,
      'members': members,
      'maxMembers': maxMembers,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TribeModel.fromMap(Map<String, Object> map) {
    if (map == null) return null;

    return TribeModel(
      id: map['id'] as String ?? '',
      tribeName: map['tribeName'] as String ?? '',
      description: map['description'] as String ?? '',
      avatar: map['avatar'] as String ?? '',
      locale: map['locale'] as String ?? '',
      ownerId: map['ownerId'] as String ?? '',
      status: map['status'] as String ?? '',
      members: List<String>.from(map['members'] as List<String> ?? const []),
      maxMembers: map['maxMembers'] as int ?? 0,
      createdAt: map['createdAt'] as int ?? 0,
      updatedAt: map['updatedAt'] as int ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TribeModel.fromJson(String source) {
    final sourceMap = json.decode(source) as Map<String, Object>;
    return TribeModel.fromMap(sourceMap);
  }
}
