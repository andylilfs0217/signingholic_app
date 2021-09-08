import 'package:flutter/material.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/video_list/video_list_bloc.dart';
import 'package:provider/provider.dart';

class AppVideoSearchBar extends StatefulWidget {
  const AppVideoSearchBar({Key? key}) : super(key: key);

  @override
  _AppVideoSearchBarState createState() => _AppVideoSearchBarState();
}

class _AppVideoSearchBarState extends State<AppVideoSearchBar> {
  TextEditingController _searchController = TextEditingController();
  String originalInput = '';
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppThemeColor.searchBarColor,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        suffixIcon: IconButton(
          onPressed: () {
            _searchController.clear();
            if ('' != originalInput) {
              context
                  .read<VideoListBloc>()
                  .add(VideoListFetchEvent(search: ''));
              originalInput = '';
            }
          },
          icon: Icon(Icons.clear),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      onSubmitted: (val) {
        if (val != originalInput)
          context.read<VideoListBloc>().add(VideoListFetchEvent(search: val));
        originalInput = val;
      },
    );
  }
}
