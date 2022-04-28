import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pixabay_pagination_example/models/image_model.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/size_config.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/ui_utils.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/widgets/responsive_safe_area.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/widgets/spacing_widgets.dart';
import 'package:pixabay_pagination_example/utils/theme/text_themes.dart';
import 'package:pixabay_pagination_example/view/widgets/image_tile.dart';

class ImagePreviewScreen extends StatelessWidget {
  final ImageModel imageModel;

  const ImagePreviewScreen({
    Key? key,
    required this.imageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          // statusBarColor: const Color(0xffC42B6E),
          statusBarColor: Colors.black54,
        ),
        child: ResponsiveSafeArea(
          builder: (context, size) {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HSpace(4),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24.vdp(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Image Preview",
                            style: AppTextThemes().headline3.copyWith(
                                  height: 1,
                                  color: Colors.white,
                                ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Hero(
                    tag: imageModel.previewURL,
                    child: ImageTile(
                      imageModel: imageModel,
                      imageWidth: size.width,
                      imageHeight: getScaledImageHeight(
                        imageModel.imageHeight.toDouble(),
                        imageModel.imageWidth.toDouble(),
                        size.width,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
