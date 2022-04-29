import 'package:flutter/material.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/size_config.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/widgets/spacing_widgets.dart';
import 'package:pixabay_pagination_example/utils/theme/text_themes.dart';

class SearchPromptingWidget extends StatelessWidget {
  const SearchPromptingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const VSpace(100),
          Icon(
            Icons.search_rounded,
            size: 200.vdp(),
            color: Colors.grey.withOpacity(.5),
          ),
          Text(
            "Search for images using the search bar ...",
            style: AppTextThemes().headline2.copyWith(
                  color: Colors.black54,
                ),
            textAlign: TextAlign.center,
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
