import 'dart:convert';

import 'package:tribeseed/core/enums/auth_status.dart';
import 'package:uuid/uuid.dart';

class UserModel {
  final String id;
  final String displayName;
  final String aboutMe;
  final String photoUrl;
  final String locale;
  final String emailAddress;
  final bool emailVerified;
  final String authStatus;
  final int createdAt;
  final int updatedAt;

  UserModel({
    this.id,
    this.displayName,
    this.aboutMe,
    this.photoUrl,
    this.locale,
    this.emailAddress,
    this.emailVerified,
    this.authStatus,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.generate({
    String displayName,
    String emailAddress,
    AuthStatus authStatus,
  })  : id = Uuid().v4(),
        displayName = displayName ?? 'Test User',
        aboutMe = '',
        photoUrl = '',
        locale = 'en',
        emailAddress = emailAddress ?? 'test@user.com',
        emailVerified = false,
        authStatus = authStatus.name ?? AuthStatus.pendingVerification.name,
        createdAt = DateTime.now().millisecondsSinceEpoch,
        updatedAt = DateTime.now().millisecondsSinceEpoch;

  UserModel copyWith({
    String displayName,
    String aboutMe,
    String photoUrl,
    String locale,
    bool emailVerified,
    String authStatus,
    int createdAt,
    int updatedAt,
  }) {
    return UserModel(
      id: id,
      displayName: displayName ?? this.displayName,
      aboutMe: aboutMe ?? this.aboutMe,
      photoUrl: photoUrl ?? this.photoUrl,
      locale: locale ?? this.locale,
      emailAddress: emailAddress,
      emailVerified: emailVerified ?? this.emailVerified,
      authStatus: authStatus ?? this.authStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.id == id &&
        o.displayName == displayName &&
        o.aboutMe == aboutMe &&
        o.photoUrl == photoUrl &&
        o.locale == locale &&
        o.emailAddress == emailAddress &&
        o.emailVerified == emailVerified &&
        o.authStatus == authStatus &&
        o.createdAt == createdAt &&
        o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        displayName.hashCode ^
        aboutMe.hashCode ^
        photoUrl.hashCode ^
        locale.hashCode ^
        emailAddress.hashCode ^
        emailVerified.hashCode ^
        authStatus.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return '''
      UserModel(
        id: $id,
        displayName: $displayName,
        aboutMe: $aboutMe,
        photoUrl: $photoUrl,
        locale: $locale,
        emailAddress: $emailAddress,
        emailVerified: $emailVerified,
        authStatus: $authStatus,
        createdAt: $createdAt,
        updatedAt: $updatedAt,
      )''';
  }

  Map<String, Object> toMap() {
    return <String, Object>{
      'id': id,
      'displayName': displayName,
      'aboutMe': aboutMe,
      'photoUrl': photoUrl,
      'locale': locale,
      'emailAddress': emailAddress,
      'emailVerified': emailVerified,
      'authStatus': authStatus,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, Object> map) {
    if (map == null) return null;

    return UserModel(
      id: map['id'] as String ?? '',
      displayName: map['displayName'] as String ?? '',
      aboutMe: map['aboutMe'] as String ?? '',
      photoUrl: map['photoUrl'] as String ?? '',
      locale: map['locale'] as String ?? '',
      emailAddress: map['emailAddress'] as String ?? '',
      emailVerified: map['emailVerified'] as bool ?? false,
      authStatus: map['authStatus'] as String ?? '',
      createdAt: map['createdAt'] as int ?? 0,
      updatedAt: map['updatedAt'] as int ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) {
    final sourceMap = json.decode(source) as Map<String, Object>;
    return UserModel.fromMap(sourceMap);
  }
}
