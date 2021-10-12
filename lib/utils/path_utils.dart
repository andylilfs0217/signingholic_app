import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:singingholic_app/global/variables.dart';

class PathUtils {
  static Uri getApiUri(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri(
        scheme: ENV == EnvironmentStage.development ? 'http' : 'https',
        host: dotenv.get('THINKSHOPS_URL'),
        port: int.tryParse(dotenv.maybeGet('THINKSHOPS_PORT') ?? ''),
        path: path,
        queryParameters: queryParameters);
  }

  static String getImagePathWithId(
      int? accountId, String? category, int? imageId, String? imageName) {
    return PathUtils.getApiUri(
            '/site_content/$accountId/$category/$imageId/$imageName')
        .toString();
  }

  static String getSiteImage(int? accountId, String? imageName) {
    return PathUtils.getApiUri('/site_content/$accountId/site/$imageName')
        .toString();
  }
}
