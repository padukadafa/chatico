import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatico/data/data_sources/user_remote_data_source.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double? radius;
  final String uid;
  const UserAvatar(this.uid, {super.key, this.radius});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: UserRemoteDataSource().getUserAvatar(uid),
        builder: (context, snapshot) {
          return CachedNetworkImage(
            imageUrl: snapshot.data ?? "",
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                backgroundImage: imageProvider,
                radius: radius,
              );
            },
            errorWidget: (context, url, error) {
              return CircleAvatar(
                radius: radius,
              );
            },
            placeholder: (context, url) {
              return CircleAvatar(
                radius: radius,
              );
            },
          );
        });
  }
}
