import 'package:flutter/material.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/size_config.dart';

class VSpace extends StatelessWidget {
  double height = 0;

  VSpace(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: (height).vdp());
  }
}

class HSpace extends StatelessWidget {
  double width = 0;

  HSpace(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: (width).hdp());
  }
}
