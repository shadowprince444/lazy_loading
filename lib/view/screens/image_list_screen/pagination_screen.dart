import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pixabay_pagination_example/controllers/pagination_controller.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/size_config.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/ui_utils.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/widgets/responsive_safe_area.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/widgets/spacing_widgets.dart';
import 'package:pixabay_pagination_example/utils/theme/text_themes.dart';
import 'package:pixabay_pagination_example/view/screens/image_list_screen/widgets/image_list.dart';
import 'package:pixabay_pagination_example/view/screens/image_list_screen/widgets/suggestion_tile_list_widget.dart';
import 'package:pixabay_pagination_example/view/widgets/app_custom_scaffold.dart';

class PaginatedScreen extends StatefulWidget {
  const PaginatedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PaginatedScreen> createState() => _PaginatedScreenState();
}

class _PaginatedScreenState extends State<PaginatedScreen> {
  final textFieldFocusNode = FocusNode();

  String searchTerm = "Avengers";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final PaginationController _controller = Get.find<PaginationController>();

  searchImages() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    searchTerm = searchController.text;
    if (searchTerm.isNotEmpty) {
      _controller.resetSearchedImages();
      _controller.paginateResponse(searchTerm);
      _scrollController.addListener(() {
        if (!_controller.isLoading) {
          if (_scrollController.position.outOfRange && _scrollController.position.userScrollDirection != ScrollDirection.forward) {
            _controller.paginateResponse(searchTerm);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () {
          if (!_controller.isLoading) {
            searchController.clear();
            textFieldFocusNode.unfocus();
            _controller.showSuggestion();
            _controller.removeSelectedSearchSuggestion();
            _controller.resetSearchedImages();
          }
          return Future.value(false);
        },
        child: AppCustomScaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          statusBarColor: Colors.white,
          body: ResponsiveSafeArea(
            builder: (context, size) {
              return SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 64.vdp(),
                      ),
                      child: Text(
                        "Search for images",
                        style: AppTextThemes().headline2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.vdp(),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 56.vdp(),
                            width: 56.vdp(),
                            child: GestureDetector(
                                onTap: () {
                                  _controller.removeSelectedSearchSuggestion();
                                  searchImages();
                                },
                                child: Icon(
                                  Icons.search_rounded,
                                  color: Colors.black45,
                                  size: 60.vdp(),
                                )
                                // SvgPicture.asset(
                                //   "assets/images/custom_search_icon.svg",
                                // ),
                                ),
                          ),
                          const HSpace(8),
                          Expanded(
                            flex: 12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  cursorColor: Colors.black,
                                  controller: searchController,
                                  focusNode: textFieldFocusNode,
                                  onEditingComplete: () {
                                    _controller.removeSelectedSearchSuggestion();
                                    _controller.hideSuggestion();
                                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                                    searchImages();
                                  },
                                  maxLines: 1,
                                  strutStyle: StrutStyle.disabled,
                                  style: AppTextThemes().headline4.copyWith(
                                        // fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.none,
                                      ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    enabled: true,
                                    enabledBorder: searchInputBorder,
                                    focusedBorder: searchInputBorder,
                                    border: searchInputBorder,
                                  ),
                                ),
                                const VSpace(4),
                                Container(
                                  height: 2.vdp(),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(
                                      1.vdp(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SuggestionTileList(
                      onTapOnTile: (index) {
                        _controller.selectSearchSuggestion(index);
                        setState(() {
                          searchController.text = _controller.suggestiveSearches[index].searchText;
                        });
                        searchImages();
                      },
                    ),
                    Expanded(
                      child: ImageList(
                        width: size.width,
                        scrollController: _scrollController,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
