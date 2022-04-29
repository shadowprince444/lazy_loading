import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pixabay_pagination_example/models/api_response_model.dart';
import 'package:pixabay_pagination_example/models/pixaby_response_model.dart';
import 'package:pixabay_pagination_example/repository/pixabay_repo.dart';

import '../models/search_suggestion_model.dart';

class PaginationController extends GetxController {
  bool showSearchSuggestion = true;
  SearchSuggestionModel? selectedSearchSuggestion;
  List<SearchSuggestionModel> suggestiveSearches = [
    SearchSuggestionModel(iconPath: "assets/images/custom_flower_icon.svg", searchText: "Flowers"),
    SearchSuggestionModel(iconPath: "assets/images/custom_cat_icon.svg", searchText: "Cats"),
    SearchSuggestionModel(iconPath: "assets/images/custom_bird_icon.svg", searchText: "Birds"),
    SearchSuggestionModel(iconPath: "assets/images/custom_tree_icon.svg", searchText: "Nature"),
  ];
  bool isLoading = false;
  final _pixabayRepository = PixabayRepo();
  PixabayImageResponseModel? pixabayImageResponseModel;
  int totalPages = 1, currentPage = 1, imagesPerPage = 15;

  resetSearchedImages() {
    totalPages = 1;
    currentPage = 1;
    pixabayImageResponseModel = null;
    update();
  }

  setLoading() {
    isLoading = true;
    update();
  }

  showSuggestion() {
    showSearchSuggestion = true;
    update();
  }

  hideSuggestion() {
    showSearchSuggestion = false;
    update();
  }

  removeLoading() {
    isLoading = false;
    update();
  }

  selectSearchSuggestion(int index) {
    selectedSearchSuggestion = suggestiveSearches[index];
    update();
  }

  removeSelectedSearchSuggestion() {
    selectedSearchSuggestion = null;
    update();
  }

  paginateResponse(String searchTerm) async {
    setLoading();
    if (currentPage <= totalPages) {
      searchTerm = Uri.encodeQueryComponent(searchTerm);

      final response = await _pixabayRepository.getImagesByPages(
        imagesPerPage,
        searchTerm,
        pageIndex: currentPage,
      );
      if (response.status == ApiResponseStatus.completed) {
        addImagesToTheList(response.data);
      }
    }

    debugPrint("Current Index: $currentPage");

    removeLoading();
  }

  void addImagesToTheList(model) {
    if (currentPage < 2) {
      pixabayImageResponseModel = model;
      totalPages = (pixabayImageResponseModel!.total / imagesPerPage).ceil();
    } else {
      pixabayImageResponseModel!.hits.addAll(model.hits);
    }
    currentPage++;
    update();
  }
}
