import 'package:flutter_dotenv/flutter_dotenv.dart';

class PathUtils {
  static String getImagePath(
      int accountId, String category, int imageId, String imageName) {
    return '${dotenv.get('THINKSHOPS_URL')}/site_content/$accountId/$category/$imageId/$imageName';
  }
}
