import '../../../domain/server/http_client/api_helper.dart';
import '../model/search_list_model.dart';

class SearchBarRepository extends ApiHelper {

  Future<SearchListModel> getSearchList({
    required String search,
    String? type, // movie, series, episode
    String? year,
    int page = 1,
  }) async {
    Map<String, dynamic> params = {};
    params['s'] = search;
    if (type != null && type.isNotEmpty) {
      params['type'] = type;
    }
    if (year != null && year.isNotEmpty) {
      params['y'] = year;
    }
    params['page'] = page.toString();
    params['r'] = 'json';

    return SearchListModel.fromJson(await requestHandler.get("", queryParams: params));
  }

  /// ==/@ Search with specific type filter @/==
  Future<SearchListModel> searchMovies({
    required String search,
    String? year,
    int page = 1,
  }) async {
    return getSearchList(
      search: search,
      type: 'movie',
      year: year,
      page: page,
    );
  }

  Future<SearchListModel> searchSeries({
    required String search,
    String? year,
    int page = 1,
  }) async {
    return getSearchList(
      search: search,
      type: 'series',
      year: year,
      page: page,
    );
  }

  Future<SearchListModel> searchEpisodes({
    required String search,
    String? year,
    int page = 1,
  }) async {
    return getSearchList(
      search: search,
      type: 'episode',
      year: year,
      page: page,
    );
  }
}