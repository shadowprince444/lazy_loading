import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_pagination_example/models/image_model.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/widgets/spacing_widgets.dart';
import 'package:pixabay_pagination_example/view/screens/image_preview_screen/image_preview_screen.dart';

class ImageTile extends StatelessWidget {
  final ImageModel imageModel;
  final double imageHeight, imageWidth;

  const ImageTile({
    Key? key,
    required this.imageModel,
    required this.imageWidth,
    required this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VSpace(2),
        GestureDetector(
          onTap: () => Get.to(
            () => ImagePreviewScreen(imageModel: imageModel),
          ),
          child: SizedBox(
            width: imageWidth,
            height: imageHeight,
            child: CachedNetworkImage(
              imageUrl: imageModel.largeImageURL,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) => Stack(
                children: [
                  Image.network(
                    imageModel.previewURL,
                    fit: BoxFit.contain,
                    height: double.infinity,
                    width: double.infinity,
                    errorBuilder: (context, object, trace) => const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}
