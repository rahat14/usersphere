import 'package:flutter/material.dart';
import '../../../../core/text_styles.dart';
import '../../data/models/UserListResp.dart';
import 'cachedCircleAvatar.dart';


Widget userTile(BuildContext context, User user) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    leading: CachedCircleAvatar(radius: 24, imageUrl: user.avatar ?? ''),
    title: Text(user.userFullName),
    titleTextStyle: CustomTextStyle.of(context).titleMediumStyle(),
    subtitle: Text(user.email ?? ''),
    subtitleTextStyle: CustomTextStyle.of(context).bodyMediumStyle(),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    tileColor: Colors.white,
  );
}
