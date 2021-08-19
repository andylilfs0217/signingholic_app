import 'package:flutter/material.dart';

/// A widget that is displayed when an image is not found and show the users that there is an error occured.
class ImageNotFound extends StatelessWidget {
  /// Create Image not found widget.
  const ImageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildErrorIcon(),
        _buildErrTitle(),
        _buildErrMsg(),
      ],
    );
  }

  /// Create Error icon.
  Widget _buildErrorIcon() => Icon(Icons.error);

  /// Create Error title showing the key message of the error.
  Widget _buildErrTitle() => Text('Image cannot be found');

  /// Create Error message showing the details of the error.
  Widget _buildErrMsg() => Text(
      'The image you are looking for does not exist or an other error occured.');
}
