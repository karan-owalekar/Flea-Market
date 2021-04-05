import 'package:meta/meta.dart';

@immutable
class UserModel {
  const UserModel(
      {@required this.uid, this.email, this.photoUrl, this.displayName});

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
}
