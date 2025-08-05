import 'dart:developer';
import 'package:get/get.dart';
import 'package:ott_app/src/features/search/controller/search_repo.dart';
import '../model/search_list_model.dart';

class SearchBarController extends GetxController implements GetxService {
  static SearchBarController get current => Get.find();
  final SearchBarRepository repository = SearchBarRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    _hasError = false;
    update();
  }

  void _setErrorState(bool hasError) {
    _isLoading = false;
    _hasError = hasError;
    update();
  }

  SearchListModel? searchModel;

  // Updated method to support type and year filters
  Future getSearchList({
    required String search,
    String? type,
    String? year,
    int page = 1,
  }) async {
    try {
      _setLoadingState(true);

      final response = await repository.getSearchList(
        search: search,
        type: type,
        year: year,
        page: page,
      );
      searchModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  Future searchMovies({
    required String search,
    String? year,
    int page = 1,
  }) async {
    return getSearchList(search: search, type: 'movie', year: year, page: page);
  }

  Future searchSeries({
    required String search,
    String? year,
    int page = 1,
  }) async {
    return getSearchList(search: search, type: 'series', year: year, page: page);
  }

  Future searchEpisodes({
    required String search,
    String? year,
    int page = 1,
  }) async {
    return getSearchList(search: search, type: 'episode', year: year, page: page);
  }

  // Clear search results
  void clearSearch() {
    searchModel = null;
    _isLoading = false;
    _hasError = false;
    update();
  }

  /// -> Get search results count
  int get searchResultsCount {
    return searchModel?.search?.length ?? 0;
  }

  /// -> Get total results from API
  String? get totalResults {
    return searchModel?.totalResults;
  }

  /// -> Check if search was successful
  bool get isSearchSuccess {
    return searchModel?.response == "True";
  }

  /// -> Get specific search item by index
  Search? getSearchItem(int index) {
    if (searchModel?.search != null && index >= 0 && index < searchModel!.search!.length) {
      return searchModel!.search![index];
    }
    return null;
  }

  /// -> Filter results by type (movie, series, episode)
  List<Search> getResultsByType(String type) {
    if (searchModel?.search == null) return [];

    return searchModel!.search!
        .where((item) => item.type?.toLowerCase() == type.toLowerCase())
        .toList();
  }

  /// -> Get movies only
  List<Search> get movies {
    return getResultsByType('movie');
  }

  /// -> Get series only
  List<Search> get series {
    return getResultsByType('series');
  }

  /// -> Get episodes only
  List<Search> get episodes {
    return getResultsByType('episode');
  }

  /// -> Filter results by year
  List<Search> getResultsByYear(String year) {
    if (searchModel?.search == null) return [];

    return searchModel!.search!
        .where((item) => item.year == year)
        .toList();
  }

  /// -> Get unique years from current results
  List<String> get availableYears {
    if (searchModel?.search == null) return [];

    Set<String> years = {};
    for (var item in searchModel!.search!) {
      if (item.year != null && item.year!.isNotEmpty) {
        years.add(item.year!);
      }
    }

    List<String> sortedYears = years.toList();
    sortedYears.sort((a, b) => b.compareTo(a)); // Sort descending
    return sortedYears;
  }

  /// -> Get search statistics
  Map<String, int> get searchStats {
    if (searchModel?.search == null) return {};

    Map<String, int> stats = {
      'movies': 0,
      'series': 0,
      'episodes': 0,
    };

    for (var item in searchModel!.search!) {
      if (item.type != null) {
        String type = item.type!.toLowerCase();
        if (stats.containsKey(type)) {
          stats[type] = stats[type]! + 1;
        }
      }
    }

    return stats;
  }
}