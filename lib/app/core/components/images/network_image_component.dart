import 'package:cached_network_image/cached_network_image.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageComponent extends StatelessWidget {
  const NetworkImageComponent({Key? key, required this.imageLink, this.fit, this.errorWidget}) : super(key: key);

  final String imageLink;
  final BoxFit? fit;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: imageLink,
        fit: fit ?? BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            color: MainColors.whiteColor,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Opacity(
                opacity: 0.1,
                child: SvgPicture.asset(
                  '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
      ),
    );
  }
}
