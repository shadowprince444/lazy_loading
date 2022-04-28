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
        VSpace(2),
        GestureDetector(
          onTap: () => Get.to(
            () => ImagePreviewScreen(imageModel: imageModel),
          ),
          child: SizedBox(
            width: imageWidth,
            height: imageHeight,
            child: Image.network(
              imageModel.largeImageURL,
              fit: BoxFit.contain,
              loadingBuilder: (context, widget, image) {
                if (image == null) {
                  return widget;
                } else {
                  return Image.network(
                    imageModel.previewURL,
                    fit: BoxFit.contain,
                    errorBuilder: (context, object, trace) => const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                    ),
                  );
                }
              },
              errorBuilder: (context, object, trace) => const Icon(
                Icons.broken_image,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
