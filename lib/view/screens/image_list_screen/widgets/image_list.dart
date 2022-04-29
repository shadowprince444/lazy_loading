import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_pagination_example/controllers/pagination_controller.dart';
import 'package:pixabay_pagination_example/models/image_model.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/size_config.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/ui_utils.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/widgets/spacing_widgets.dart';
import 'package:pixabay_pagination_example/view/screens/image_list_screen/widgets/empty_results_widget.dart';
import 'package:pixabay_pagination_example/view/screens/image_list_screen/widgets/search_prompting_widget.dart';
import 'package:pixabay_pagination_example/view/widgets/image_tile.dart';

class ImageList extends StatelessWidget {
  final double width;

  const ImageList({
    Key? key,
    required this.width,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaginationController>(
      builder: (paginationController) {
        if (paginationController.pixabayImageResponseModel == null) {
          if (paginationController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SearchPromptingWidget();
          }
        } else {
          if (paginationController.pixabayImageResponseModel!.hits.isNotEmpty) {
            return ColoredBox(
              color: Colors.grey.withOpacity(.5),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paginationController.pixabayImageResponseModel!.hits.length,
                      itemBuilder: (context, index) {
                        ImageModel imageModel = paginationController.pixabayImageResponseModel!.hits[index];

                        return Hero(
                          tag: imageModel.previewURL,
                          child: ImageTile(
                            imageModel: imageModel,
                            imageWidth: width,
                            imageHeight: getScaledImageHeight(
                              imageModel.imageHeight.toDouble(),
                              imageModel.imageWidth.toDouble(),
                              width,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        ImageModel imageModel = paginationController.pixabayImageResponseModel!.hits[index];
                        return Column(
                          children: [
                            const VSpace(8),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.vdp(),
                                horizontal: 8.hdp(),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 16.vdp(),
                                        ),
                                        const HSpace(4),
                                        Text(
                                          imageModel.user,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.vdp(),
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  buildIconText(
                                    imageModel.likes.toString(),
                                    Icons.thumb_up_alt_outlined,
                                  ),
                                  const HSpace(4),
                                  buildIconText(
                                    imageModel.comments.toString(),
                                    Icons.chat,
                                  ),
                                  const HSpace(4),
                                  buildIconText(
                                    imageModel.downloads.toString(),
                                    Icons.download_rounded,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    GetBuilder<PaginationController>(
                      builder: (controller) {
                        if (controller.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const VSpace(0);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const EmptyResultsWidget();
          }
        }
      },
    );
  }

  Widget buildIconText(String text, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(
          8.vdp(),
        ),
        border: Border.all(
          color: Colors.grey,
          width: .5.vdp(),
        ),
      ),
      padding: EdgeInsets.all(
        4.vdp(),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 12.vdp(),
          ),
          const HSpace(4),
          Text(
            text,
          ),
        ],
      ),
    );
  }
}
