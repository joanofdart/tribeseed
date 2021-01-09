import 'package:tribeseed/core/enums/auth_status.dart';

class UserModel {
  final String id;
  final String displayName;
  final String aboutMe;
  final String photoURL;
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
    this.photoURL,
    this.locale,
    this.emailAddress,
    this.emailVerified,
    this.authStatus,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.initial()
      : id = null,
        displayName = '',
        aboutMe = '',
        photoURL = '',
        locale = 'en',
        emailAddress = '',
        emailVerified = false,
        authStatus = AuthStatus.guest.name,
        createdAt = null,
        updatedAt = null;

  UserModel copyWith({
    String displayName,
    String aboutMe,
    String photoURL,
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
      photoURL: photoURL ?? this.photoURL,
      locale: locale ?? this.locale,
      emailVerified: emailVerified ?? this.emailVerified,
      authStatus: authStatus ?? this.authStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
