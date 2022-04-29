import 'package:flutter/material.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/size_config.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/widgets/spacing_widgets.dart';

class EmptyResultsWidget extends StatelessWidget {
  const EmptyResultsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const VSpace(150),
          Icon(
            Icons.warning_amber_outlined,
            size: 200.vdp(),
            color: Colors.grey.withOpacity(.5),
          ),
          Text(
            "No images found...",
            style: TextStyle(
              fontSize: 18.vdp(),
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
