import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatico/data/data_sources/user_remote_data_source.dart';
import 'package:chatico/di.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double? radius;
  final String? uid;
  final String? url;
  const UserAvatar({
    this.uid,
    super.key,
    this.radius,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return _userAvatar(url!);
    }
    if (uid != null) {
      return FutureBuilder<String>(
          future: getIt<UserRemoteDataSource>().getUserAvatar(uid),

          builder: (context, snapshot) {
            return _userAvatar(snapshot.data!);
          });
    }
    return CircleAvatar(
      radius: radius,
    );
  }

  Widget _userAvatar(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,

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
  }
}
