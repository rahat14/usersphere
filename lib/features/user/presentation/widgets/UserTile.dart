import 'package:flutter/material.dart';

import '../../data/models/UserListResp.dart';
import 'cached_circle_avatar.dart';

Widget userTile(User user) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    leading: CachedCircleAvatar(radius: 24, imageUrl: user.avatar ?? ''),
    title: Text(user.userFullName),
    subtitle: Text(user.email ?? ''),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    tileColor: Colors.white,
  );
}
