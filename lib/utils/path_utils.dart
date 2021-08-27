import 'package:flutter_dotenv/flutter_dotenv.dart';

class PathUtils {
  static String getImagePathWithId(
      int accountId, String category, int imageId, String imageName) {
    return '${dotenv.get('THINKSHOPS_URL')}/site_content/$accountId/$category/$imageId/$imageName';
  }

  static String getSiteImage(int accountId, String imageName) {
    return '${dotenv.get('THINKSHOPS_URL')}/site_content/$accountId/site/$imageName';
  }
}
