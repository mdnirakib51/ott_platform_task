
import '../../../domain/server/http_client/api_helper.dart';
import '../model/video_list_model.dart';

class VideoDetailsRepository extends ApiHelper {

  Future<VideoDetailsModel> getVideoDetails({
    required String imdbId,
    String? title,
    String? type, // movie, series, episode
    String? year,
    String? plot, // short, full
  }) async {
    Map<String, dynamic> params = {};
    params['i'] = imdbId;
    params['t'] = title;
    if (type != null && type.isNotEmpty) {
      params['type'] = type;
    }
    if (year != null && year.isNotEmpty) {
      params['y'] = year;
    }
    params['plot'] = 'full';
    params['r'] = 'json';

    return VideoDetailsModel.fromJson(await requestHandler.get("", queryParams: params));
  }

}
