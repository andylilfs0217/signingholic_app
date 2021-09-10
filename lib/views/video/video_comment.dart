import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

/// The like and dislike status of the user
enum LikeStatus { LIKE, DISLIKE, NONE }

/// A single comment widget
class VideoComment extends StatefulWidget {
  /// Create a single comment widget
  const VideoComment({Key? key}) : super(key: key);

  @override
  _VideoCommentState createState() => _VideoCommentState();
}

class _VideoCommentState extends State<VideoComment> {
  /// User's current like status
  LikeStatus _likeStatus = LikeStatus.NONE;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCommentHeader(),
          _buildCommentRating(),
          _buildCommentText(),
          _buildCommentLikes(),
          _buildCommentReplies(),
        ],
      ),
    );
  }

  /// The header of a comment (contains the name who published the comment and the date on publish)
  Widget _buildCommentHeader() {
    return RichText(
        text: TextSpan(
            text: 'name',
            style: Theme.of(context).textTheme.subtitle2,
            children: [
          TextSpan(text: ' - '),
          TextSpan(text: 'published date'),
        ]));
  }

  /// The rating of the video by the user (5 stars in total)
  Widget _buildCommentRating() {
    return RatingBarIndicator(
      rating: 3.5,
      itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
      itemCount: 5,
      itemSize: 20,
      unratedColor: Colors.amber.shade100,
    );
  }

  /// The comment of the user
  Widget _buildCommentText() {
    return Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vitae lacus sit amet nunc eleifend molestie. Sed malesuada, nunc eget vehicula finibus, libero tortor dapibus lectus, pharetra consequat risus nisl vitae neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In maximus lacinia magna, ac facilisis diam euismod vitae. Aliquam vel vehicula enim, pulvinar venenatis sapien. Nullam vitae tincidunt mi. Proin aliquam mi ut euismod congue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Curabitur velit urna, tempor in odio in, vestibulum tincidunt purus. Maecenas cursus tristique quam. Mauris cursus porta enim, ac pharetra augue ornare eget. Praesent laoreet, urna quis egestas aliquam, sapien mauris blandit ex, eget aliquet nunc erat efficitur erat. Nam mollis, ligula sed venenatis scelerisque, augue mi lacinia dui, sed vulputate nulla felis vulputate urna. Pellentesque ac hendrerit erat.');
  }

  /// Button row for likes, dislikes and replies
  Widget _buildCommentLikes() {
    return Row(
      children: [
        // Like button
        TextButton.icon(
            onPressed: () {
              setState(() {
                _likeStatus = _likeStatus == LikeStatus.LIKE
                    ? LikeStatus.NONE
                    : LikeStatus.LIKE;
              });
            },
            icon: Icon(_likeStatus == LikeStatus.LIKE
                ? Icons.thumb_up
                : Icons.thumb_up_outlined),
            label: Text('105')),
        // Dislike button
        TextButton.icon(
            onPressed: () {
              setState(() {
                _likeStatus = _likeStatus == LikeStatus.DISLIKE
                    ? LikeStatus.NONE
                    : LikeStatus.DISLIKE;
              });
            },
            icon: Icon(_likeStatus == LikeStatus.DISLIKE
                ? Icons.thumb_down
                : Icons.thumb_down_alt_outlined),
            label: Text('12')),
        // Reply button
        TextButton.icon(
            onPressed: () {
              print('Reply');
            },
            icon: Icon(Icons.reply),
            label: Text('3')),
      ],
    );
  }

  /// Button which will pop up all the replies of the comment
  Widget _buildCommentReplies() {
    return TextButton(
        onPressed: () {
          print('Show replies');
        },
        child: Text('SHOW 3 REPLIES'));
  }
}
