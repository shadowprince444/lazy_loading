import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pixabay_pagination_example/controllers/pagination_controller.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/size_config.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/widgets/spacing_widgets.dart';
import 'package:pixabay_pagination_example/utils/theme/text_themes.dart';

class SuggestionTileList extends StatelessWidget {
  final Function(int) onTapOnTile;

  const SuggestionTileList({
    required this.onTapOnTile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaginationController>(builder: (paginationController) {
      if (paginationController.showSearchSuggestion) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.hdp(),
                vertical: 16.vdp(),
              ),
              child: Text(
                "Search Suggestions",
                style: AppTextThemes().headline3,
              ),
            ),
            SizedBox(
              height: 88.vdp(),
              width: double.infinity,
              // color: Colors.amber,
              // padding: EdgeInsets.symmetric(vertical: 8.vdp()),
              child: ListView.builder(
                // padding: EdgeInsets.only(
                //   left: 8.vdp(),
                // ),
                itemCount: paginationController.suggestiveSearches.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  bool isSelected = paginationController.suggestiveSearches[index].searchText == paginationController.selectedSearchSuggestion?.searchText;

                  if (isSelected) {
                    return ImageTile(
                      isSelected: isSelected,
                      onTapOnTile: onTapOnTile,
                      index: index,
                      paginationController: paginationController,
                    );
                  } else {
                    return ImageTile(
                      isSelected: isSelected,
                      onTapOnTile: onTapOnTile,
                      index: index,
                      paginationController: paginationController,
                    );
                  }
                },
              ),
            ),
          ],
        );
      } else {
        return const VSpace(0);
      }
    });
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.isSelected,
    required this.onTapOnTile,
    required this.index,
    required this.paginationController,
  }) : super(key: key);
  final bool isSelected;
  final Function(int p1) onTapOnTile;
  final PaginationController paginationController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapOnTile(
        index,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey : Colors.transparent,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                32.vdp(),
              ),
            ),
          ),
          height: 88.vdp(),
          padding: EdgeInsets.symmetric(
            vertical: 4.vdp(),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 10.hdp(),
          ),
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                height: 56.vdp(),
                width: 56.vdp(),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white : const Color(0xFF606060),
                ),
                padding: EdgeInsets.all(
                  8.vdp(),
                ),
                child: SvgPicture.asset(
                  paginationController.suggestiveSearches[index].iconPath,
                ),
              ),
              SizedBox(
                  height: 16.vdp(),
                  child: Text(
                    paginationController.suggestiveSearches[index].searchText.toUpperCase(),
                    style: AppTextThemes().bodyText2.copyWith(color: isSelected ? Colors.white : Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
