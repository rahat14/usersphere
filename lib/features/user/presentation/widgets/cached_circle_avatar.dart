import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CachedCircleAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 40,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      backgroundImage: CachedNetworkImageProvider(imageUrl),
    );
  }
}
