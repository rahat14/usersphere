import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/models/UserListResp.dart';
import '../widgets/cachedCircleAvatar.dart';

class UserDetailsScreen extends StatefulWidget {
  final User user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        title: Text('User Details'),
        titleTextStyle: CustomTextStyle.of(context).headingSmallTextStyle(),
        centerTitle: false,
        //backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CachedCircleAvatar(radius: 60, imageUrl: widget.user.avatar ?? ''),

            const SizedBox(height: 20),
            Text(
              widget.user.userFullName,
              style: CustomTextStyle.of(context).headingMediumTextStyle(),
            ),

            const SizedBox(height: 40),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(widget.user.userFullName),
                titleTextStyle: CustomTextStyle.of(context).titleMediumStyle(),
                subtitle: Text('Full Name'),
                subtitleTextStyle:
                    CustomTextStyle.of(context).bodyMediumStyle(),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const Icon(Icons.email),
                title: Text(widget.user.email ?? ''),
                titleTextStyle: CustomTextStyle.of(context).titleMediumStyle(),
                subtitle: const Text('Email Address'),
                subtitleTextStyle:
                    CustomTextStyle.of(context).bodyMediumStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
