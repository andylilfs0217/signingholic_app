import 'package:flutter_dotenv/flutter_dotenv.dart';

class PathUtils {
  static Uri getApiUri(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri(
        scheme: 'https',
        host: dotenv.get('THINKSHOPS_URL'),
        path: path,
        queryParameters: queryParameters);
  }

  static String getImagePathWithId(
      int accountId, String category, int imageId, String imageName) {
    return PathUtils.getApiUri(
            '/site_content/$accountId/$category/$imageId/$imageName')
        .toString();
  }

  static String getSiteImage(int accountId, String imageName) {
    return PathUtils.getApiUri('/site_content/$accountId/site/$imageName')
        .toString();
  }
}
