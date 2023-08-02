import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:stroy_app/repositories/story_repository.dart';
import 'package:stroy_app/stories/story.dart';

class StoryController extends GetxController {
  final StoryRepository _storyRepository = StoryRepository();
  final int _size = 15;
  int _page = 1;
  var hasMore = true.obs;
  var stories = <Story>[].obs;

  Future getStory() async {
    try {
      List<Story> response = await _storyRepository.fetchStories(_page, _size);
      if (response.length < _size) {
        hasMore.value = false;
      }

      stories.addAll(response);
      _page++;
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refreshData() async {
    _page = 1;
    hasMore.value = true;
    stories.value = [];

    await getStory();
  }
}
