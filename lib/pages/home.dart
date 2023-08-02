import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stroy_app/controllers/story_controller.dart';
import 'package:get/get.dart';

import 'package:stroy_app/controllers/login_controller.dart';
import 'package:stroy_app/pages/login.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LoginController loginController = Get.put(LoginController());
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final StoryController state = Get.put(StoryController());

    state.getStory();

    Future onRefresh() async {
      state.refreshData();
    }

    void onScroll() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      if (maxScroll == currentScroll && state.hasMore.value) {
        state.getStory();
      }
    }

    scrollController.addListener(onScroll);

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            height: 8,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Westory",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final SharedPreferences? prefs = await _pref;
              prefs?.clear();
              Get.off(LoginPage());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Obx(
          () => ListView.builder(
            controller: scrollController,
            itemCount: state.hasMore.value
                ? state.stories.length + 1
                : state.stories.length,
            itemBuilder: (context, index) {
              if (index < state.stories.length) {
                return Card(
                  margin: EdgeInsets.only(bottom: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/6596121.png'),
                              radius: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.stories[index].name ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    timeago.format(
                                      DateTime.parse(
                                          state.stories[index].createdAt ?? ''),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 136, 136, 136),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 11, bottom: 10),
                        child: Text(state.stories[index].description ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Image.network(
                          state.stories[index].photoUrl ?? '',
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final SharedPreferences? prefs = await _pref;
          print(
            prefs?.get('token'),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
