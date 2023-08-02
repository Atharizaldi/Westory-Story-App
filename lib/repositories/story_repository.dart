import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stroy_app/stories/story.dart';

class StoryRepository extends GetConnect {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final String _baseUrl = 'https://story-api.dicoding.dev/v1/';

  Future<List<Story>> fetchStories(int page, int size) async {
    final SharedPreferences? prefs = await _pref;
    var token = prefs?.get('token').toString();

    final response =
        await get("${_baseUrl}stories?page=$page&size=$size", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final data = response.body['listStory'];
    print(data);
    return List<Story>.from(data.map((e) => Story.fromJson(e)));
  }
}
